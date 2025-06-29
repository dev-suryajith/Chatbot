# 🎓 Admission Chatbot

A Smart, NLP-Powered Chatbot to Automate Admission Processes

## Project Overview

At **Archon Solutions**, an innovative tech solutions firm, I developed an **admission-related chatbot** to automate major admission processes and efficiently manage student inquiries.

This chatbot is built using **Python (Django), HTML, CSS, JavaScript, and MySQL** and integrates **Natural Language Processing (NLP)** to understand user questions and provide real-time responses.

The chatbot is fully responsive and works seamlessly across both desktop and mobile platforms, significantly reducing manual intervention and improving the institution’s online query management system.

## Key Features

* Automated admission queries for faster, more efficient response handling.
* Integrated Natural Language Processing (NLP) for real-time, relevant answers.
* Fully responsive design for both desktop and mobile devices.
* Cross-platform compatibility for a smooth user experience.
* Streamlined online query management with minimal manual effort.

## Tech Stack

* Backend: Python (Django)
* Frontend: HTML, CSS, JavaScript
* Database: MySQL
* NLP: spaCy, NLTK, SymSpell, YAKE

## Screenshots

![Screenshot 2025-06-29 154719](https://github.com/user-attachments/assets/2723fa80-c7cc-495e-9f24-85b5f5ef298f)

![Screenshot 2025-06-29 154845](https://github.com/user-attachments/assets/4f480477-d3dd-4712-b49e-9de517b764db)

![Screenshot 2025-06-29 154910](https://github.com/user-attachments/assets/34a8e8b4-147c-491e-bf3e-6ddc0ac3d395)

![Screenshot 2025-06-29 154936](https://github.com/user-attachments/assets/7e43cc3a-0d30-47e1-9587-3a24529405f7)

![Screenshot 2025-06-29 155017](https://github.com/user-attachments/assets/d3c218db-9318-431e-b24a-c1a6137148f7)


## Installation and Setup

### Prerequisites

* Python 3.9
* MySQL
* Git

### Setup Steps

1. Clone the repository:
   `git clone https://github.com/dev-suryajith/Chatbot.git`

2. Navigate to the project directory:
   `cd Chatbot`

3. (Optional) Create and activate a virtual environment:

   * On macOS/Linux:
     `python -m venv venv && source venv/bin/activate`
   * On Windows:
     `python -m venv venv && venv\Scripts\activate`

4. Install the dependencies:

   * `pip install Django`
   * `pip install spacy`
   * `pip install symspellpy`
   * `pip install yake`
   * `pip install nltk`
   * `pip install requests`

5. Download additional resources:

   * Run: `python -m spacy download en_core_web_sm`
   * In Python shell:

     import nltk
     nltk.download('punkt')
     nltk.download('stopwords')
     nltk.download('wordnet')

6. Configure the database connection in `settings.py` to match your MySQL setup.

7. Apply database migrations:
   `python manage.py migrate`

8. Start the development server:
   `python manage.py runserver`

9. Access the chatbot at:
   `http://127.0.0.1:8000/`

## Project Impact

* Streamlined the admission inquiry process.
* Reduced manual workload for admission teams.
* Provided real-time assistance across devices.
* Improved overall user engagement and satisfaction.

## Contact

**Suryajith S.**
Email: [suryajithss2608@gmail.com](mailto:suryajithss2608@gmail.com)
LinkedIn: [www.linkedin.com/in/suryajith-ss](http://www.linkedin.com/in/suryajith-ss)

## Acknowledgements

Special thanks to **Archon Solutions** for the opportunity to build this impactful solution.
