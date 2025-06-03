from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import psycopg2

app = FastAPI()

DB_HOST = "planitdb.c30c2ai28fyz.us-east-2.rds.amazonaws.com"
DB_NAME = "postgres"
DB_USER = "PlanItDB"
DB_PASSWORD = "dixie123"
DB_PORT = 5432

class User(BaseModel):
    id: int
    username: str
    password: str
    email: str
    rating: int
    role: str

def get_conn():
    return psycopg2.connect(
        host=DB_HOST,
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        port=DB_PORT
    )

@app.post("/users/")
def create_user(user: User):
    try:
        conn = get_conn()
        cur = conn.cursor()
        cur.execute(
            "INSERT INTO users (id, username, password, email, rating, role) VALUES (%s, %s, %s, %s, %s, %s)",
            (user.id, user.username, user.password, user.email, user.rating, user.role)
        )
        conn.commit()
        cur.close()
        conn.close()
        return {"message": "User created"}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@app.get("/users/{user_id}")
def get_user(user_id: int):
    try:
        conn = get_conn()
        cur = conn.cursor()
        cur.execute("SELECT id, username, password, email, rating, role FROM users WHERE id = %s", (user_id,))
        row = cur.fetchone()
        cur.close()
        conn.close()
        if row:
            return User(id=row[0], username=row[1], password=row[2], email=row[3], rating=row[4], role=row[5])
        else:
            raise HTTPException(status_code=404, detail="User not found")
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@app.put("/users/{user_id}")
def update_user(user_id: int, user: User):
    try:
        conn = get_conn()
        cur = conn.cursor()
        cur.execute(
            "UPDATE users SET username=%s, password=%s, email=%s, rating=%s, role=%s WHERE id=%s",
            (user.username, user.password, user.email, user.rating, user.role, user_id)
        )
        conn.commit()
        cur.close()
        conn.close()
        return {"message": "User updated"}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@app.patch("/users/{user_id}")
def patch_user(user_id: int, user: User):
    try:
        conn = get_conn()
        cur = conn.cursor()
        fields = []
        values = []
        for field, value in user.dict(exclude_unset=True).items():
            if field != "id":
                fields.append(f"{field}=%s")
                values.append(value)
        if not fields:
            raise HTTPException(status_code=400, detail="No fields to update")
        values.append(user_id)
        sql = f"UPDATE users SET {', '.join(fields)} WHERE id=%s"
        cur.execute(sql, tuple(values))
        conn.commit()
        cur.close()
        conn.close()
        return {"message": "User patched"}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@app.delete("/users/{user_id}")
def delete_user(user_id: int):
    try:
        conn = get_conn()
        cur = conn.cursor()
        cur.execute("DELETE FROM users WHERE id=%s", (user_id,))
        conn.commit()
        cur.close()
        conn.close()
        return {"message": "User deleted"}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))