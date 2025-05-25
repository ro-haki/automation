FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    unzip \
    curl \
    gcc \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN curl -L https://github.com/t3l3machus/Villain/archive/refs/tags/V2.2.1.zip -o villain.zip && \
    unzip villain.zip && \
    rm villain.zip && \
    mv Villain-2.2.1 villain

WORKDIR /opt/villain

RUN pip install --no-cache-dir -r requirements.txt
RUN chmod +x Villain.py

# currently expose only for raw reverse-tcp
EXPOSE 4444
CMD ["./Villain.py", "-n", "4444"]