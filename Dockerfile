FROM runpod/worker-comfyui:latest-base

RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git && \
    cd ComfyUI-Impact-Pack && \
    pip install --no-cache-dir -r requirements.txt && \
    python install.py

RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git

RUN cd /comfyui/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git

RUN mkdir -p /comfyui/models/ultralytics/bbox && \
    mkdir -p /comfyui/models/sams && \
    mkdir -p /comfyui/models/ipadapter && \
    wget -q -O /comfyui/models/ultralytics/bbox/face_yolov8m.pt \
      "https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt" && \
    wget -q -O /comfyui/models/sams/sam_vit_b_01ec64.pth \
      "https://dl.fbaipublicfiles.com/segment_anything/sam_vit_b_01ec64.pth" && \
    wget -q -O /comfyui/models/ipadapter/ip-adapter-plus-face_sdxl_vit-h.safetensors \
      "https://huggingface.co/h94/IP-Adapter/resolve/main/sdxl_models/ip-adapter-plus-face_sdxl_vit-h.safetensors"
