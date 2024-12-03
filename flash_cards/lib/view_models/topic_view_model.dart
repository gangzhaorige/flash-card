import 'package:flash_cards/repository/topic_repository.dart';
import 'package:flash_cards/view_models/loading_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/topic.dart';

class TopicViewModel extends LoadingViewModel {

  final TopicRepository _topicRepository;

  TopicViewModel(this._topicRepository);

  List<TopicInfo> _topics = [];

  List<TopicInfo> get topics => _topics;

  Future<void> fetchTopics() async {
    if (isLoading) return; // Prevent duplicate fetch calls
    isLoading = true;
    notifyListeners();
    try {
      var response = await _topicRepository.fetchTopics();
      List<TopicInfo> list = [];
      if(response?.statusCode == 200) {
        for(dynamic data in response?.data) {
          list.add(TopicInfo.fromJson(data));
        }
      } 
      _topics = list;
      notifyListeners();
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching topics: $error');
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createNewTopic(String subject, String description) async {
    if (isLoading) return; // Prevent duplicate fetch calls
    isLoading = true;
    notifyListeners();
    try {
      var data = {'subject': subject, 'description': description};
      var response = await _topicRepository.createTopic(data);
      if(response?.statusCode == 201) {
        TopicInfo newTopic = TopicInfo.fromJson(response?.data);
        _topics.insert(0, newTopic);
        notifyListeners();
      } 
    } catch (error) {
      if (kDebugMode) {
        print('Error Creating topics: $error');
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateTopic(int id, String subject, String description) async {
    if (isLoading) return; // Prevent duplicate fetch calls
    isLoading = true;
    notifyListeners();
    try {
      var data = {'subject': subject, 'description': description};
      var response = await _topicRepository.updateTopic(id, data);
      if(response?.statusCode == 200) {
        TopicInfo updatedTopic = TopicInfo.fromJson(response?.data);
        int index = findByTopicId(id);
        if(id == -1) {
          return;
        }
        _topics[index] = updatedTopic;
        notifyListeners();
      } 
    } catch (error) {
      if (kDebugMode) {
        print('Error Creating topics: $error');
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  int findByTopicId(id) {
    for(int i = 0; i < _topics.length; i++) {
      if(_topics[i].id == id) {
        return i;
      }
    }
    return -1;
  }

  int getNumberOfDecks() {
    return _topics.length;
  }

  Future<void> deleteTopic(int topicId) async {
    if (isLoading) return; // Prevent duplicate fetch calls
    isLoading = true;
    notifyListeners();
    try {
      var response = await _topicRepository.deleteTopic(topicId);
      if(response?.statusCode == 204) {
        int removedTopicIndex = findByTopicId(topicId);
        _topics.removeAt(removedTopicIndex);
        notifyListeners();
      } 
    } catch (error) {
      if (kDebugMode) {
        print('Error Creating topics: $error');
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void updateNumCards(int topicId, int count) {
    for(var topicInfo in _topics) {
      if(topicInfo.id == topicId) {
        topicInfo.numCards += count;
        notifyListeners();
        return;
      }
    }
  }
}