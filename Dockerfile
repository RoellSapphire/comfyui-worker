# ═══════════════════════════════════════════════════════════════
#  Custom ComfyUI Worker for RunPod Serverless
#  Includes: Impact Pack (FaceDetailer) + IP-Adapter Plus
#  Base: Official RunPod ComfyUI worker 5.7.1
# ═══════════════════════════════════════════════════════════════
FROM runpod/worker-comfyui:5.7.1-base

# ── Install custom nodes ──
RUN cd /comfyui/custom_nodes && \
    # Impact Pack (FaceDetailer, SAM, face detection)
    git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git && \
    cd ComfyUI-Impact-Pack && \
    pip install -r requirements.txt && \
    # Install Impact Pack submodules
    python install.py && \
    cd .. && \
    # IP-Adapter Plus (face consistency across frames)
    git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git && \
    # ComfyUI Manager (useful for debugging)
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git

# ── Download face detection models for Impact Pack ──
RUN mkdir -p /comfyui/models/ultralytics/bbox && \
    mkdir -p /comfyui/models/ultralytics/segm && \
    mkdir -p /comfyui/models/sams && \
    mkdir -p /comfyui/models/ipadapter && \
    # YOLOv8 face detection (for FaceDetailer)
    wget -q -O /comfyui/models/ultralytics/bbox/face_yolov8m.pt \
      "https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt" && \
    # SAM model (for segmentation in FaceDetailer)
    wget -q -O /comfyui/models/sams/sam_vit_b_01ec64.pth \
      "https://dl.fbaipublicfiles.com/segment_anything/sam_vit_b_01ec64.pth" && \
    # IP-Adapter Plus Face model (SDXL - works with Illustrious/Hyphoria)
    wget -q -O /comfyui/models/ipadapter/ip-adapter-plus-face_sdxl_vit-h.safetensors \
      "https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter-plus-face_sdxl_vit-h.safetensors"

# ── The worker will also scan /runpod-volume/models/ for your ──
# ── checkpoints, LoRAs, embeddings from the network volume    ──

