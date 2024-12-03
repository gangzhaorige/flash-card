json_object = '''
{
    "questions": [
        {
            "question": "Which device is required for setting up the 3D LiDAR development kit?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "X-NUCLEO-53L8A1",
                    "is_correct": true
                },
                {
                    "choice_id": 2,
                    "answer": "Arduino Uno",
                    "is_correct": false
                },
                {
                    "choice_id": 3,
                    "answer": "Raspberry Pi",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "BeagleBone Black",
                    "is_correct": false
                }
            ]
        },
        {
            "question": "What software is used for flashing firmware to the STM32 board?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "Arduino IDE",
                    "is_correct": false
                },
                {
                    "choice_id": 2,
                    "answer": "STM32CubeIDE",
                    "is_correct": true
                },
                {
                    "choice_id": 3,
                    "answer": "Eclipse",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "Visual Studio Code",
                    "is_correct": false
                }
            ]
        },
        {
            "question": "Which virtual machine software is mentioned for Mac OS users?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "VMware Fusion",
                    "is_correct": false
                },
                {
                    "choice_id": 2,
                    "answer": "Parallels Desktop",
                    "is_correct": true
                },
                {
                    "choice_id": 3,
                    "answer": "VirtualBox",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "QEMU",
                    "is_correct": false
                }
            ]
        },
        {
            "question": "What is the purpose of the VL53L8CX_GUI software?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "To edit source code",
                    "is_correct": false
                },
                {
                    "choice_id": 2,
                    "answer": "To manage device connections and flash firmware",
                    "is_correct": true
                },
                {
                    "choice_id": 3,
                    "answer": "To design 3D models",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "To compile C++ programs",
                    "is_correct": false
                }
            ]
        },
        {
            "question": "Which driver is necessary for the VL53L8CX setup?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "STSW Link Driver",
                    "is_correct": true
                },
                {
                    "choice_id": 2,
                    "answer": "FTDI Driver",
                    "is_correct": false
                },
                {
                    "choice_id": 3,
                    "answer": "CH340 Driver",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "Prolific Driver",
                    "is_correct": false
                }
            ]
        },
        {
            "question": "What file format is used to save recorded data from the LiDAR?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "XML",
                    "is_correct": false
                },
                {
                    "choice_id": 2,
                    "answer": "CSV",
                    "is_correct": true
                },
                {
                    "choice_id": 3,
                    "answer": "JSON",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "TXT",
                    "is_correct": false
                }
            ]
        },
        {
            "question": "Which IDE is used for developing projects without GUI?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "NetBeans",
                    "is_correct": false
                },
                {
                    "choice_id": 2,
                    "answer": "STM32CubeIDE",
                    "is_correct": true
                },
                {
                    "choice_id": 3,
                    "answer": "IntelliJ IDEA",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "PyCharm",
                    "is_correct": false
                }
            ]
        },
        {
            "question": "Which software is recommended for setting up a serial port?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "HyperTerminal",
                    "is_correct": false
                },
                {
                    "choice_id": 2,
                    "answer": "CoolTerm",
                    "is_correct": true
                },
                {
                    "choice_id": 3,
                    "answer": "Putty",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "Tera Term",
                    "is_correct": false
                }
            ]
        },
        {
            "question": "What is the primary function of the X-NUCLEO-53L8A1?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "To provide power to the system",
                    "is_correct": false
                },
                {
                    "choice_id": 2,
                    "answer": "To act as a 3D LiDAR sensor",
                    "is_correct": true
                },
                {
                    "choice_id": 3,
                    "answer": "To store data",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "To display output",
                    "is_correct": false
                }
            ]
        },
        {
            "question": "Which connectivity option is used to connect the X-NUCLEO-53L8A1 to a computer?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "Bluetooth",
                    "is_correct": false
                },
                {
                    "choice_id": 2,
                    "answer": "USB to Mini-USB",
                    "is_correct": true
                },
                {
                    "choice_id": 3,
                    "answer": "Ethernet",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "Wi-Fi",
                    "is_correct": false
                }
            ]
        },
        {
            "question": "What is the role of the Nucleo F401RE in the setup?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "To act as a power supply",
                    "is_correct": false
                },
                {
                    "choice_id": 2,
                    "answer": "To serve as a microcontroller board",
                    "is_correct": true
                },
                {
                    "choice_id": 3,
                    "answer": "To provide network connectivity",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "To store data",
                    "is_correct": false
                }
            ]
        },
        {
            "question": "What is the first step in using the VL53L8CX_GUI software?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "Select the device from the dropdown",
                    "is_correct": false
                },
                {
                    "choice_id": 2,
                    "answer": "Click the refresh list to detect the connected device",
                    "is_correct": true
                },
                {
                    "choice_id": 3,
                    "answer": "Enable Data Log",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "Flash the firmware",
                    "is_correct": false
                }
            ]
        },
        {
            "question": "Which operating system requires a virtual machine for the setup?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "Windows",
                    "is_correct": false
                },
                {
                    "choice_id": 2,
                    "answer": "Mac OS",
                    "is_correct": true
                },
                {
                    "choice_id": 3,
                    "answer": "Linux",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "Android",
                    "is_correct": false
                }
            ]
        },
        {
            "question": "What is the purpose of the 'Flash FW' button in the VL53L8CX_GUI?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "To update the GUI software",
                    "is_correct": false
                },
                {
                    "choice_id": 2,
                    "answer": "To flash the required software into the STM32 Board",
                    "is_correct": true
                },
                {
                    "choice_id": 3,
                    "answer": "To save the current settings",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "To reset the device",
                    "is_correct": false
                }
            ]
        },
        {
            "question": "Which tool is used to configure the serial port settings?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "CoolTerm",
                    "is_correct": true
                },
                {
                    "choice_id": 2,
                    "answer": "Notepad++",
                    "is_correct": false
                },
                {
                    "choice_id": 3,
                    "answer": "Excel",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "WordPad",
                    "is_correct": false
                }
            ]
        },
        {
            "question": "What is the function of the 'Start' button in the VL53L8CX_GUI?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "To stop recording data",
                    "is_correct": false
                },
                {
                    "choice_id": 2,
                    "answer": "To begin recording data",
                    "is_correct": true
                },
                {
                    "choice_id": 3,
                    "answer": "To refresh the device list",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "To connect to the device",
                    "is_correct": false
                }
            ]
        },
        {
            "question": "Which software is used to import the sample ranging project?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "STM32CubeIDE",
                    "is_correct": true
                },
                {
                    "choice_id": 2,
                    "answer": "Arduino IDE",
                    "is_correct": false
                },
                {
                    "choice_id": 3,
                    "answer": "Code::Blocks",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "Eclipse",
                    "is_correct": false
                }
            ]
        },
        {
            "question": "What is the correct order of steps to flash firmware using VL53L8CX_GUI?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "Connect device, Flash FW, Refresh list, Select device",
                    "is_correct": false
                },
                {
                    "choice_id": 2,
                    "answer": "Refresh list, Select device, Flash FW, Refresh list, Connect",
                    "is_correct": true
                },
                {
                    "choice_id": 3,
                    "answer": "Select device, Refresh list, Flash FW, Connect",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "Flash FW, Refresh list, Connect, Select device",
                    "is_correct": false
                }
            ]
        },
        {
            "question": "What should you do if the data displayed is random characters?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "Restart the computer",
                    "is_correct": false
                },
                {
                    "choice_id": 2,
                    "answer": "Check and configure Port, BaudRate, Data Bit, and Stop Bit settings",
                    "is_correct": true
                },
                {
                    "choice_id": 3,
                    "answer": "Reinstall the software",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "Disconnect and reconnect the device",
                    "is_correct": false
                }
            ]
        },
        {
            "question": "Which file is used to import the sample ranging project in STM32CubeIDE?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "Projects/NUCLEO-F401RE/Example/53L8A1/SimpleRanging",
                    "is_correct": true
                },
                {
                    "choice_id": 2,
                    "answer": "Projects/NUCLEO-F401RE/Example/53L8A1/AdvancedRanging",
                    "is_correct": false
                },
                {
                    "choice_id": 3,
                    "answer": "Projects/NUCLEO-F401RE/Example/53L8A1/BasicRanging",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "Projects/NUCLEO-F401RE/Example/53L8A1/ComplexRanging",
                    "is_correct": false
                }
            ]
        },
        {
            "question": "What is the purpose of enabling Data Log in VL53L8CX_GUI?",
            "choices": [
                {
                    "choice_id": 1,
                    "answer": "To display data on the screen",
                    "is_correct": false
                },
                {
                    "choice_id": 2,
                    "answer": "To save the record in a CSV file",
                    "is_correct": true
                },
                {
                    "choice_id": 3,
                    "answer": "To reset the device",
                    "is_correct": false
                },
                {
                    "choice_id": 4,
                    "answer": "To update the firmware",
                    "is_correct": false
                }
            ]
        }
    ]
}
'''