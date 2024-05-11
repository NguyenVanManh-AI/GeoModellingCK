import asyncio
import websockets
import random

async def send_random_value(websocket, path):
    with open('actions.txt', 'r') as file:
        actions = file.readlines()
    
    while actions:
        action = actions.pop(0).strip()  # Get the first action and remove it from the list
        await websocket.send(action)
        await asyncio.sleep(1)

start_server = websockets.serve(send_random_value, "localhost", 8765)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
