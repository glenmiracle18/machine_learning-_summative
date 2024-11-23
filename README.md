# Learning Mode Recommendation System

A Flutter application that predicts student adaptability in online learning environments using a machine learning model deployed on Google Cloud Run.

## Vidoe Submission Link 
(Comment: I wanted to submit to youtube but I had some issues so I submitted to loom)
https://www.loom.com/share/77261ca7691945f6bf68058c16b74a0a?sid=5367985d-a753-4ee6-9182-43fa3f7219e7

## Project Overview

This system helps predict a student's adaptability level (High, Moderate, or Low) for online learning based on various parameters including:
- Personal Information (Gender, Age, Education Level)
- Environmental Factors (Location, Financial Condition)
- Technical Setup (Internet Type, Device, Network Type)

### Architecture
- Frontend: Flutter mobile application
- Backend: FastAPI Python service
- ML Model: Trained model deployed on Google Cloud Run
- Deployment: Docker container on Google Cloud Run

### Public API Endpoint
```
https://summative-ml-4-794291747792.us-central1.run.app
```

API Routes:
- Health Check: `GET /`
- Predict: `POST /predict`

Example prediction request:
```bash
curl -X POST \
-H "Content-Type: application/json" \
-d '{
    "Gender": "Boy",
    "Age": "21-25",
    "Education_Level": "College",
    "Institution_Type": "Government",
    "IT_Student": "Yes",
    "Location": "Yes",
    "Load_shedding": "Low",
    "Financial_Condition": "Mid",
    "Internet_Type": "Wifi",
    "Network_Type": "4G",
    "Class_Duration": "3-6",
    "Self_Lms": "No",
    "Device": "Mobile"
}' \
https://summative-ml-4-794291747792.us-central1.run.app/predict
```

## Project Structure

```
frontend/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   └── learning_data.dart
│   ├── screens/
│   │   ├── personal_info_screen.dart
│   │   ├── environment_screen.dart
│   │   ├── technical_setup_screen.dart
│   │   └── prediction_results_screen.dart
│   ├── services/
│   │   └── api_service.dart
│   ├── utils/
│   │   └── constants.dart
│   └── widgets/
│       ├── custom_dropdown.dart
│       ├── navigation_buttons.dart
│       └── step_indicator.dart
├── android/
├── ios/
├── pubspec.yaml
└── README.md

<!-- Model development -->

📦src
 ┣ 📂__pycache__
 ┃ ┣ 📜app.cpython-312.pyc
 ┃ ┣ 📜predict.cpython-312.pyc
 ┃ ┗ 📜utils.cpython-312.pyc
 ┣ 📂templates
 ┃ ┗ 📜index.html
 ┣ 📜__init__.py
 ┣ 📜app.py
 ┣ 📜predict.py
 ┣ 📜train_model.py
 ┗ 📜utils.py

<!-- requirements and docker -->
|-Dcokerfile
|-requirements.txt
|-README.md
```

## Backend Deployment

The backend is containerized and deployed on Google Cloud Run:

1. Built Docker image:
```bash
docker build -t learning-mode-api .
```

2. Pushed to Docker Hub:
```bash
docker tag learning-mode-api username/learning-mode-api:latest
docker push username/learning-mode-api:latest
```

3. Deployed to Google Cloud Run:
```bash
gcloud run deploy summative-ml \
  --image gcr.io/PROJECT_ID/learning-mode-api \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

## Local Development Setup

### Prerequisites
- Flutter SDK
- Dart SDK
- Android Studio or VS Code
- Python 3.9+
- Docker (optional)

### Running the Flutter App

1. Clone the repository:
```bash
git clone https://github.com/yourusername/learning-mode-recommendation.git
cd learning-mode-recommendation
```

2. Get dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Running the Backend Locally

1. Install Python dependencies:
```bash
pip install -r requirements.txt
```

2. Run the FastAPI server:
```bash
uvicorn app:app --reload
```

The API will be available at `http://localhost:8000`

### Running with Docker

1. Build the Docker image:
```bash
docker build -t learning-mode-api .
```

2. Run the container:
```bash
docker run -p 8000:8000 learning-mode-api
```

## Features

- Multi-step form for data collection
- Real-time validation
- Loading states and error handling
- Responsive design
- Clean architecture
- State management
- API integration
- Proper error handling
- Form validation
- User feedback

## Technical Details

### Frontend
- Flutter 3.x
- HTTP package for API calls
- Custom widgets for reusability
- Form validation
- State management using setState
- Proper null safety implementation

### Backend
- FastAPI
- Python 3.9
- Machine Learning model
- Docker containerization
- Google Cloud Run deployment
- CORS enabled
- Input validation using Pydantic
- Error handling
- Logging

### API Response Format
```json
{
  "prediction": "High",
  "status": "success"
}
```

## Future Improvements

- Add user authentication
- Save prediction history
- Offline support
- More detailed predictions
- Enhanced error handling
- Analytics dashboard
- Dark mode support
- Localization

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
