from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
import psycopg2
import bcrypt

import psycopg2

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Or specify your frontend URL for better security
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

DB_HOST = "planitdb.c30c2ai28fyz.us-east-2.rds.amazonaws.com"
DB_NAME = "postgres"
DB_USER = "PlanItDB"
DB_PASSWORD = "dixie123"
DB_PORT = 5432

class User(BaseModel):
    username: str
    password: str
    email: str
    rating: int
    role: str

class LoginRequest(BaseModel):
    username: str
    password: str

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
            "INSERT INTO users ( username, password, email, rating, role) VALUES ( %s, %s, %s, %s, %s)",
            (user.username, user.password, user.email, user.rating, user.role)
        )
        conn.commit()
        cur.close()
        conn.close()
        return {"message": "User created"}
    except Exception as e:
        print("Error in create_user:", e) 
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
    
@app.get("/users/check/{username}")
def get_user_by_username(username: str):
    try:
        conn = get_conn()
        cur = conn.cursor()
        cur.execute("SELECT id, username, password, email, rating, role FROM users WHERE username = %s", (username,))
        row = cur.fetchone()
        cur.close()
        conn.close()
        print("helo user cchekc")
        if row:
            return True
        else:
            raise HTTPException(status_code=404, detail="User not found")
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))


@app.post("/users/login/")
def login(request: LoginRequest):
    try:
        conn = get_conn()
        cur = conn.cursor()
        cur.execute("SELECT password FROM users WHERE username = %s", (request.username,))
        row = cur.fetchone()
        cur.close()
        conn.close()
        print("hit login")
        if row and bcrypt.checkpw(request.password.encode(), row[0].encode()):
            return {"success": True, "message": "Login successful"}
        else:
            return {"success": False, "message": "Invalid username or password"}
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