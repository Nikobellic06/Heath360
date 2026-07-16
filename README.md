# Health360
Health360 is a smart medical report management system that digitizes and organizes patient records. It converts handwritten prescriptions, highlights key insights, and creates a dynamic health summary. Doctors can access data instantly in emergencies, ensuring faster, accurate, and efficient treatment.

## Service Ports (Permanent)

- Health360_ML summary service: 8000
- Health360_ml1 face-recognition service: 8001
- Health360_Portal backend: 4000

## Start Commands

1. Summary service
	- Folder: Health360_ML
	- Command: python -m app.main

2. Face-recognition service
	- Folder: Health360_ml1
	- Command: python main.py

3. Portal backend
	- Folder: Health360_Portal/backend
	- Command: npm run dev

4. Portal frontend
	- Folder: Health360_Portal/frontend
	- Command: npm run dev

## Environment Setup

- Use Health360_Portal/backend/.env.example and set:
	- FACE_VERIFY_URL=http://127.0.0.1:8002
  - ML_REPORT_BASE_URL=http://127.0.0.1:8000/temp
- Use Health360_ML/.env.example for ML_HOST and ML_PORT.
- Use Health360_ml1/.env.example for FACE_HOST and FACE_PORT.
