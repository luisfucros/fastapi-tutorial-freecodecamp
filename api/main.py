from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from api.database import engine
from api.routers import post, user, auth, vote
from mangum import Mangum
import os


# models.Base.metadata.create_all(bind=engine)

app = FastAPI(root_path=os.getenv("ROOT_PATH", "/dev/"))
handler = Mangum(app)

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


app.include_router(post.router)
app.include_router(user.router)
app.include_router(auth.router)
app.include_router(vote.router)


@app.get("/")
def root():
    return {"status": "ok"}
