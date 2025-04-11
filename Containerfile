FROM quay.io/modh/odh-pytorch-notebook:v3-20250321 AS base

USER 0

# Set working directory
WORKDIR /workspace

# Clone and install SDG from SDG Research (pre-installed dependencies)
RUN git clone https://github.com/Red-Hat-AI-Innovation-Team/SDG-Research.git && \
    cd SDG-Research && \
    git checkout knowledge-demo-notebooks && \
    pip install --no-cache-dir -r ./requirements.txt && \
    pip install --no-cache-dir . && \
    cd .. && \
    rm -rf SDG-Research  # Clean up to reduce image size

COPY overlay/ /

ENTRYPOINT ["/opt/start.sh"]

USER 1001
