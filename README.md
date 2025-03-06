# spell_champ_frontend

A new Flutter project.

Spell-Champ-Frontend/

│── assets/               # Static assets like fonts, images, and icons
│   ├── fonts/            # Custom fonts used in the app
│   ├── images/           # PNG, JPG images
│   ├── vectors/          # Logo
│── lib/                  
│   ├── common/           # Common utilities bloc and widgets
│   ├── core/             # configures for app images,colors,vectors,url
│   ├── data/             # API calls and data management
│   ├── domain/           # user request logic
│   ├── presentation/                        # UI & State Management
│   │   ├── auth/         
│   │   │   ├── pages/                       # Login, Signup, and authentication UI
│   │   │   │   ├── Signin.dart              # Sign-in screen UI
│   │   │   │   ├── Signup.dart              # Sign-up screen UI
│   │   │   │   ├── Signup_or_Signin.dart    # Option screen for login/signup
│   │   ├── home/         # Main home screen 
│   │   │   ├── bloc/     # State management for home page
│   │   │   ├── pages/    
│   │   │   ├── widgets/  
│   │   ├── intro/        
│   │   │   ├── pages/    
│   │   │   │   ├── welcome_screen.dart 
│   │   ├── profile/      # User profile-related UI and logic
│   │   │   ├── bloc/     # State management for profile
│   │   │   ├── pages/    
│   │   │   │   ├── profile.dart          # Profile screen UI
│   ├── main.dart         # Entry point of the application

