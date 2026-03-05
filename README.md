# ComfyUI Worker - Prompt Bible Edition

Custom RunPod serverless worker for ComfyUI with face quality and consistency nodes.

## Included Custom Nodes
- **Impact Pack** — FaceDetailer for automatic face enhancement
- **IP-Adapter Plus** — Face consistency across frames using reference images
- **ComfyUI Manager** — Node management

## Included Models (baked into image)
- `face_yolov8m.pt` — YOLO face detection for FaceDetailer
- `sam_vit_b_01ec64.pth` — SAM segmentation for FaceDetailer
- `ip-adapter-plus-face_sdxl_vit-h.safetensors` — IP-Adapter face model

## Models from Network Volume
Checkpoints, LoRAs, embeddings, and VAE are loaded from the network volume at `/runpod-volume/models/`.

## Deploy
1. Push this repo to GitHub
2. In RunPod → Serverless → New Endpoint → Start from GitHub Repo
3. Connect your GitHub, select this repo
4. Attach your network volume
5. Deploy!
