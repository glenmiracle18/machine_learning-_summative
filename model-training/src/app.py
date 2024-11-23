import os
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import Dict, Any, Literal
from predict import predict_student_adaptability
import uvicorn
import logging


# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(
    title="Student Adaptability Prediction API",
    description="API for predicting student adaptability in online learning environments",
    version="1.0.0"
)

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class StudentInfo(BaseModel):
    Gender: Literal['Boy', 'Girl']
    Age: Literal['16-20', '21-25', '26-30', '>30']
    Education_Level: Literal['School', 'College', 'University']
    Institution_Type: Literal['Government', 'Non Government']
    IT_Student: Literal['Yes', 'No']
    Location: Literal['Yes', 'No']
    Load_shedding: Literal['High', 'Mid', 'Low']
    Financial_Condition: Literal['Poor', 'Mid', 'Rich']
    Internet_Type: Literal['Mobile Data', 'Wifi']
    Network_Type: Literal['2G', '3G', '4G']
    Class_Duration: Literal['1-3', '3-6', '>6']
    Self_Lms: Literal['Yes', 'No']
    Device: Literal['Mobile', 'Computer', 'Tab']

    class Config:
        json_schema_extra = {
            "example": {
                "Gender": "Boy",
                "Age": "16-20",
                "Education_Level": "College",
                "Institution_Type": "Government",
                "IT_Student": "No",
                "Location": "Yes",
                "Load_shedding": "Low",
                "Financial_Condition": "Mid",
                "Internet_Type": "Wifi",
                "Network_Type": "4G",
                "Class_Duration": "1-3",
                "Self_Lms": "No",
                "Device": "Mobile"
            }
        }



# Add a health check endpoint
@app.get("/")
async def root():
    return {"status": "healthy", "message": "API is running"}

@app.post("/predict")
async def predict(student_info: StudentInfo) -> Dict[str, Any]:
    try:
        logger.info("Received prediction request") 
        student_dict = {
            'Gender': student_info.Gender,
            'Age': student_info.Age,
            'Education Level': student_info.Education_Level,
            'Institution Type': student_info.Institution_Type,
            'IT Student': student_info.IT_Student,
            'Location': student_info.Location,
            'Load-shedding': student_info.Load_shedding,
            'Financial Condition': student_info.Financial_Condition,
            'Internet Type': student_info.Internet_Type,
            'Network Type': student_info.Network_Type,
            'Class Duration': student_info.Class_Duration,
            'Self Lms': student_info.Self_Lms,
            'Device': student_info.Device
        }
        prediction = predict_student_adaptability(student_dict)
        
        logger.info(f"Prediction result: {prediction}")
        return {
            "prediction": prediction,
            "status": "success"
        }
    except Exception as e:
        logger.error(f"Error during prediction: {str(e)}")
        raise HTTPException(status_code=500, detail=str(e))

if __name__ == "__main__":
    # Get port from environment variable or default to 8080
    port = int(os.getenv("PORT", "8080"))
    
    # Log the port being used
    logger.info(f"Starting server on port {port}")
    
    # Run the app
    uvicorn.run(app, host="0.0.0.0", port=port)