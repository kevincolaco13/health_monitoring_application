# MVP: Health Monitor
# MedTech Visionary Products

## PROBLEM
In today's world, medical treatments often come with a plethora of information in the form of medical reports. However, deciphering these reports can be challenging for individuals without a medical background. What if there was a way to obtain a basic analysis of these reports with just a simple upload? That's where our solution comes in.



## SOLUTION
We have developed a platform that allows users to upload their medical reports and receive an analysis in return. This analysis includes information about the effects of the disease that can be inferred from the data in the report, as well as preventive measures to be taken. Additionally, the platform provides visualizations of the data, making it easier for users to comprehend the information presented. The goal of our platform is to empower everyone with a basic understanding of the information that can be gleaned from their medical reports.



## TECHNOLOGY
The technology behind our platform is based on Optical Character Recognition (OCR), a process that involves extracting raw data from the medical reports.

We have leveraged Google Cloud Service and AMD instance to implement the OCR technology in our platform. Once the raw data is extracted, it is cleaned and converted into JSON format, which is then sent as an API to the application. The application then processes the data and presents the results and visualizations to the user.

In addition to the OCR technology, we have utilized several other tools and technologies in the development of our project. 

This includes:

* Google Vision API, which helps with OCR , image recognition and analysis.
* Google Cloud Function, which allows for serverless computing and handling of API requests. 
* We have also made use of AMD Instance, a high-performance virtual machine that enables efficient processing of the raw data from the medical reports.
* Furthermore, Python has been employed in our project for data cleaning, data processing and analysis. 
* Lastly, OpenAI, a leading artificial intelligence research organization, has been used to enhance the capabilities of our platform.
