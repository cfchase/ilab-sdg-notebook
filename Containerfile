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

# Create an init script to clone the repo and install requirements if needed
RUN echo '#!/bin/bash' > /opt/start.sh && \
    echo 'set -e  # Exit script on first error' >> /opt/start.sh && \
    echo 'REPO_DIR="/opt/app-root/src/sdg-notebook"' >> /opt/start.sh && \
    echo 'if [ ! -d "$REPO_DIR/.git" ]; then' >> /opt/start.sh && \
    echo '    echo "Repository not found. Cloning..."' >> /opt/start.sh && \
    echo '    git clone --depth 1 https://github.com/rh-aiservices-bu/sdg-notebook.git "$REPO_DIR"' >> /opt/start.sh && \
    echo '    echo "Installing dependencies from requirements.txt..."' >> /opt/start.sh && \
    echo '    pip install --no-cache-dir -r "$REPO_DIR/requirements.txt"' >> /opt/start.sh && \
    echo 'elif [ "$REPO_DIR/requirements.txt" -nt "$REPO_DIR/.git" ]; then' >> /opt/start.sh && \
    echo '    echo "Detected changes in requirements.txt. Reinstalling dependencies..."' >> /opt/start.sh && \
    echo '    pip install --no-cache-dir -r "$REPO_DIR/requirements.txt"' >> /opt/start.sh && \
    echo 'else' >> /opt/start.sh && \
    echo '    echo "Repository already exists. Skipping clone."' >> /opt/start.sh && \
    echo 'fi' >> /opt/start.sh && \
    echo 'exec start-notebook.sh --NotebookApp.token="" --NotebookApp.password=""' >> /opt/start.sh && \
    chmod +x /opt/start.sh

ENTRYPOINT ["/opt/start.sh"]

USER 1001
