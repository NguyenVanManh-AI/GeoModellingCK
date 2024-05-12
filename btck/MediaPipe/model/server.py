import asyncio
import websockets
import random
import mysql.connector



async def send_random_value(websocket, path):
    while True:

        # Kết nối đến cơ sở dữ liệu
        conn = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",
            database="geomodellingck"
        )

        # Tạo con trỏ để thao tác với cơ sở dữ liệu
        cursor = conn.cursor()

        # Thực hiện câu lệnh SQL để lấy id và name của dòng có id lớn nhất trong bảng actions
        select_query = "SELECT id, name FROM actions ORDER BY id ASC LIMIT 1"
        cursor.execute(select_query)
        result = cursor.fetchone()
        print(result)

        if result:
            id, name = result
            print(name)
            await websocket.send(str(name))

            # Xóa dòng này bằng id
            delete_query = "DELETE FROM actions WHERE id = %s"
            cursor.execute(delete_query, (id,))  # Chèn id vào câu lệnh DELETE
            conn.commit()
        else:
            # Nếu không có dữ liệu trong bảng actions, gửi 'something' qua websocket
            await websocket.send(str('no action'))

        await asyncio.sleep(1)

start_server = websockets.serve(send_random_value, "localhost", 8765)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
