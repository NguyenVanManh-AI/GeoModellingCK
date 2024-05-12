# chay 1
import cv2
import numpy as np
import os
from matplotlib import pyplot as plt
import time
import mediapipe as mp
import math
from tensorflow.keras.models import load_model

# chay 3
def mediapipe_detection(image, model):
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB) # COLOR CONVERSION BGR 2 RGB
    image.flags.writeable = False                  # Image is no longer writeable
    results = model.process(image)                 # Make prediction
    image.flags.writeable = True                   # Image is now writeable
    image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR) # COLOR COVERSION RGB 2 BGR
    return image, results

# chay 4
async def draw_landmarks(image, results):
    mp_drawing.draw_landmarks(image, results.face_landmarks, mp_holistic.FACE_CONNECTIONS) # Draw face connections
    mp_drawing.draw_landmarks(image, results.pose_landmarks, mp_holistic.POSE_CONNECTIONS) # Draw pose connections
    mp_drawing.draw_landmarks(image, results.left_hand_landmarks, mp_holistic.HAND_CONNECTIONS) # Draw left hand connections
    mp_drawing.draw_landmarks(image, results.right_hand_landmarks, mp_holistic.HAND_CONNECTIONS) # Draw right hand connections

# chay 5
async def draw_styled_landmarks(image, results):
    # Draw pose connections
    mp_drawing.draw_landmarks(image, results.pose_landmarks, mp_holistic.POSE_CONNECTIONS,
                             mp_drawing.DrawingSpec(color=(80,22,10), thickness=2, circle_radius=4),
                             mp_drawing.DrawingSpec(color=(80,44,121), thickness=2, circle_radius=2)
                             )
    # Draw left hand connections
    mp_drawing.draw_landmarks(image, results.left_hand_landmarks, mp_holistic.HAND_CONNECTIONS,
                             mp_drawing.DrawingSpec(color=(121,22,76), thickness=2, circle_radius=4),
                             mp_drawing.DrawingSpec(color=(121,44,250), thickness=2, circle_radius=2)
                             )
    # Draw right hand connections
    mp_drawing.draw_landmarks(image, results.right_hand_landmarks, mp_holistic.HAND_CONNECTIONS,
                             mp_drawing.DrawingSpec(color=(245,117,66), thickness=2, circle_radius=4),
                             mp_drawing.DrawingSpec(color=(245,66,230), thickness=2, circle_radius=2)
                             )

# chay 6
def extract_keypoints_reduce(results):
    pose = np.array([[res.x, res.y, res.z, res.visibility] for res in results.pose_landmarks.landmark[:25]]).flatten() if results.pose_landmarks else np.zeros(25*4)
    lh = np.array([[res.x, res.y, res.z] for res in results.left_hand_landmarks.landmark]).flatten() if results.left_hand_landmarks else np.zeros(21*3)
    rh = np.array([[res.x, res.y, res.z] for res in results.right_hand_landmarks.landmark]).flatten() if results.right_hand_landmarks else np.zeros(21*3)
    return np.concatenate([pose, lh, rh])

# chay 2
mp_holistic = mp.solutions.holistic # Holistic model
mp_drawing = mp.solutions.drawing_utils # Drawing utilities


# chay 8
no_sequences = 50
sequence_length = 30
actions = ['zoomIn', 'rotateYN', 'rotateXC', 'moveNear', 'rotateYC', 'zoomOut', 'rotateXN',
 'moveTop', 'rotateZN', 'moveRight', 'rotateZC', 'moveBottom', 'moveFar',
 'moveLeft']
print(actions)

# chay 10
label_map = {label:num for num, label in enumerate(actions)}
label_map


model = load_model('actionGRUThreeLayersReduce.h5')
model.summary()

# chay 23
# 1. New detection variables
sequence = []
sentence = []
texts = []
threshold = 0.95
is_save = True
old_time = time.time()
cap = cv2.VideoCapture(0)
# Set mediapipe model

async def main(websocket, path):
    sequence = []
    sentence = []
    texts = []
    threshold = 0.95
    is_save = True
    old_time = time.time()
    cap = cv2.VideoCapture(0)

    with mp_holistic.Holistic(min_detection_confidence=0.5, min_tracking_confidence=0.5) as holistic:
        while cap.isOpened():

            # Read feed
            ret, frame = cap.read()

            # Make detections
            image, results = mediapipe_detection(frame, holistic)
            print(results)
            if (not results.left_hand_landmarks) and (not results.right_hand_landmarks):
                is_save = False
            # if (results.left_hand_landmarks):
            #     print(results.left_hand_landmarks)
            # if (results.right_hand_landmarks):
            #     print(results.right_hand_landmarks)
            # Draw landmarks
            draw_styled_landmarks(image, results)
            
            if is_save:
                # 2. Prediction logic
                keypoints = extract_keypoints_reduce(results)
                sequence.append(keypoints)
                sequence = sequence[-30:]

                if len(sequence) == 30:
                    res = model.predict(np.expand_dims(sequence, axis=0))[0]
                    print(len(res))
                    print(actions[np.argmax(res)])

                #3. Viz logic
                    if res[np.argmax(res)] > threshold:
                        if len(sentence) > 0:
                            if actions[np.argmax(res)] == sentence[-1]:
                                sentence.append(actions[np.argmax(res)])
                        else:
                            sentence.append(actions[np.argmax(res)])
                    else:
                        sentence = []

                    if len(sentence) > 5:
                        if len(texts) > 0:
                            if sentence[-1] != texts[-1]:
                                texts.append(sentence[-1])
                        else:
                            texts.append(sentence[-1])
                        # ghi texts[-1] vào dòng tiếp theo của file txt
                        new_time = time.time()
                        duration = new_time - old_time
                        old_time = new_time
                        if (duration > 2):
                            print("ACTION : ", texts[-1])
                            await websocket.send(texts[-1])
                            await asyncio.sleep(1)
                            # with open('actions.txt', 'a') as f:
                            #     f.write(texts[-1] + '\n')
                        if len(texts) > 3:
                            texts = texts[-3:]
                        sentence = sentence[-5:]

            cv2.putText(image, ' '.join(texts), (3,30),
                        cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 0), 2, cv2.LINE_AA)

            # Show to screen
            cv2.imshow('OpenCV Feed', image)
            is_save = True

            # Break gracefully
            if cv2.waitKey(10) & 0xFF == ord('q'):
                break
        cap.release()
        cv2.destroyAllWindows()

import asyncio
import websockets
import random

start_server = websockets.serve(main, "localhost", 8765)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
