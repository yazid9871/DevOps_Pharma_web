FROM python:3.11-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:99
ENV TZ=Africa/Casablanca

RUN apt-get update && apt-get install -y \
    firefox-esr \
    wget \
    xvfb \
    fluxbox \
    tzdata \
    libgtk-3-0 \
    libdbus-glib-1-2 \
    ca-certificates \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN wget -q https://github.com/mozilla/geckodriver/releases/download/v0.37.1/geckodriver-v0.37.1-linux64.tar.gz \
 && tar -xzf geckodriver-v0.37.1-linux64.tar.gz -C /usr/local/bin/ \
 && chmod +x /usr/local/bin/geckodriver \
 && rm geckodriver-v0.37.1-linux64.tar.gz

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

WORKDIR /tests
COPY Resources /tests/Resources
COPY TestSuite /tests/TestSuite
COPY run_robot.sh /run_robot.sh
RUN chmod +x /run_robot.sh && mkdir -p /tests/results

ENTRYPOINT ["/run_robot.sh"]
