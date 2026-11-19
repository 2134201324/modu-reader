FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PORT=8000

# ffmpeg / ffprobe 用于：读取视频时长与分辨率、抽取封面帧、
# 把 mkv/mov/avi 无损换封装成浏览器可播的 mp4。缺了它视频仍能入库，
# 但没有封面，且非 mp4/webm 的文件在网页里放不出来。
RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

# 删除功能依赖 ADMIN_TOKEN，未设置时接口返回 403（阅读、导入、播放不受影响）
CMD ["sh", "-c", "python -m uvicorn app:app --host 0.0.0.0 --port ${PORT}"]
