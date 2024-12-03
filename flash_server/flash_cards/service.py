import openai
from django.conf import settings

# Initialize OpenAI with the API key from settings
openai.api_key = settings.OPENAI_API_KEY

def generate_openai_response(user_input, model="gpt-4o", max_tokens=100):
    """
    Makes a request to the OpenAI API to generate a response.
    """
    system = '''
Choose the correct option(s) from the provided choices for the user's question. Then, explain why the selected choices are correct in a few sentences.

# Steps

1. **Understand the Question**: Carefully read and comprehend the user's input question to determine its intent.
2. **Evaluate the Choices**: Review each choice given and compare them against the context and requirements of the question.
3. **Select the Correct Option(s)**: Identify one or more options that correctly answer the question. Note that there may be more than one correct answer.
4. **Justify the Answer**: Write a concise explanation detailing why the selected choice(s) are correct. Focus on the key facts and logic that make this answer accurate.

# Output Format

```json
{
  "answer": ["1", "3", "4"],
  "explanation": "The primary colors in the visible spectrum are red, blue, and yellow. These colors cannot be created by combining other colors, but they can be mixed to form other colors. Green is a secondary color formed by mixing blue and yellow."
}
```

# Example

**Input**:  
Question: "What are the primary colors?"  
Choices: (1) Red, (2) Green, (3) Blue, (4) Yellow

**Output**:
```json
{
  "answer": ["1", "3", "4"],
  "explanation": "The primary colors in the visible spectrum are red, blue, and yellow. These colors cannot be created by combining other colors, but they can be mixed to form other colors. Green is a secondary color formed by mixing blue and yellow."
}
```

# Notes

- Ensure that each explanation convincingly justifies why each choice is correct, while briefly mentioning why incorrect choices do not fit.
- If the question allows for multiple correct answers, ensure all applicable choices are selected.
    ''' 
    try:
        completion = openai.chat.completions.create(
            model='gpt-4o',
            response_format={"type": "json_object"},
            messages=[
                {"role": "system", "content": system},
                {
                    "role": "user",
                    "content": f"{user_input}"
                },
            ],
            max_tokens=max_tokens,
            temperature=0.7,
        )
    except Exception as e:
        # Handle the exception
        print(f"An error occurred: {e}")
    
    
    print('here')
    return completion.choices[0].message.content


def generate_question_from_pdf(user_input, model="gpt-4o", max_tokens=10000):
    """
    Makes a request to the OpenAI API to generate a response.
    """
    system = '''
Generate 10 multiple-choice questions based on a given topic, where each question has four answer choices with one correct answer.

Ensure the output is structured in a JSON format as specified, each question contains necessary fields for question and choices, and clearly identify the correct answer.

# Steps

1. For each of the 10 questions:
   - Create a question related to the given topic.
   - Develop four answer choices for each question.
   - Determine which of the four choices is the correct one.
   - Mark the correct choice correctly within the JSON structure.

# Output Format

Output the results as a JSON array of 10 objects. Each object should represent a question and have the following structure:

```json
[
    {
        "question": "Your question here?",
        "choices": [
            {
                "choice_id": 1,
                "answer": "Choice A",
                "is_correct": false
            },
            {
                "choice_id": 2,
                "answer": "Choice B",
                "is_correct": true  // mark 'true' for the correct choice
            },
            {
                "choice_id": 3,
                "answer": "Choice C",
                "is_correct": false
            },
            {
                "choice_id": 4,
                "answer": "Choice D",
                "is_correct": false
            }
        ]
    },
    // Repeat for remaining questions
]
```

# Examples

**Example Input:** "Basic Data Structures"

**Example Output:**

```json
[
    {
        "question": "Which data structure uses LIFO (Last In, First Out) principle?",
        "choices": [
            {
                "choice_id": 1,
                "answer": "Queue",
                "is_correct": false
            },
            {
                "choice_id": 2,
                "answer": "Stack",
                "is_correct": true
            },
            {
                "choice_id": 3,
                "answer": "Array",
                "is_correct": false
            },
            {
                "choice_id": 4,
                "answer": "Linked List",
                "is_correct": false
            }
        ]
    },
    // Include 9 more structured in the same format
]
```

# Notes

- Ensure variety in question topics under the general subject area specified.
- Maintain clarity and fairness in the level of difficulty across all questions.
- Validate the accuracy of correct answers to avoid errors in question design.
    ''' 
    try:
        completion = openai.chat.completions.create(
            model='gpt-4o',
            response_format={"type": "json_object"},
            messages=[
                {"role": "system", "content": system},
                {
                    "role": "user",
                    "content": f"{user_input}"
                },
            ],
            max_tokens=max_tokens,
            temperature=0.2,
        )
    except Exception as e:
        # Handle the exception
        print(f"An error occurred: {e}")

    return completion.choices[0].message.content