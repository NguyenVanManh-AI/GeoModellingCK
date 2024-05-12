import asyncio
import websockets
import random

async def send_random_value(websocket, path):
    while True:
        await asyncio.sleep(1)
        with open('actions.txt', 'r') as file:
            lines = file.readlines()
        action = lines[0].strip() 
        await asyncio.sleep(1)
        with open('actions.txt', 'w') as file:
            file.writelines(lines[1:])
        print(action)
        await websocket.send(str(action))
        await asyncio.sleep(1)

start_server = websockets.serve(send_random_value, "localhost", 8765)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
