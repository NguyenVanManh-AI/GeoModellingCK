import asyncio
import websockets
import random

async def send_random_value(websocket, path):
    while True:
        values = ['moveLeft', 'moveRight', 'moveTop', 'moveBottom', 'rotateXC', 'rotateXN', 'rotateYC', 'rotateYN', 'rotateZC', 'rotateZN']
        value = random.choice(values)
        await websocket.send(str(value))
        await asyncio.sleep(1)

start_server = websockets.serve(send_random_value, "localhost", 8765)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
