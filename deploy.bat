@echo off
REM 🚀 Games Apps Collection - GitHub Deployment Script for Windows
REM This script automates the process of uploading games to GitHub and enabling GitHub Pages

echo.
echo 🎮 Games Apps Collection - GitHub Deployment Script
echo ==================================================

REM Check if Git is installed
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Git is not installed. Please install Git first.
    echo Visit: https://git-scm.com/downloads
    pause
    exit /b 1
)

echo [INFO] Git is installed ✓

REM Check if we're in the right directory
if not exist "index.html" (
    echo [ERROR] Please run this script from the Games Apps directory
    pause
    exit /b 1
)

echo [INFO] Directory check passed ✓

REM Ask for GitHub username
echo.
set /p GITHUB_USERNAME="[STEP] Please enter your GitHub username: "

if "%GITHUB_USERNAME%"=="" (
    echo [ERROR] GitHub username is required
    pause
    exit /b 1
)

echo [INFO] Using GitHub username: %GITHUB_USERNAME%

REM Ask for repository name
echo.
set /p REPO_NAME="[STEP] Repository name (default: games-apps-collection): "

if "%REPO_NAME%"=="" (
    set REPO_NAME=games-apps-collection
)

echo [INFO] Using repository name: %REPO_NAME%

REM Initialize Git repository if not already initialized
if not exist ".git" (
    echo [STEP] Initializing Git repository...
    git init
    echo [INFO] Git repository initialized ✓
) else (
    echo [INFO] Git repository already exists ✓
)

REM Configure Git if not configured
git config user.name >nul 2>&1
if %errorlevel% neq 0 (
    echo [STEP] Please enter your Git user name:
    set /p GIT_NAME="Git User Name: "
    git config user.name "%GIT_NAME%"
)

git config user.email >nul 2>&1
if %errorlevel% neq 0 (
    echo [STEP] Please enter your Git user email:
    set /p GIT_EMAIL="Git User Email: "
    git config user.email "%GIT_EMAIL%"
)

REM Add all files and commit
echo [STEP] Adding files to Git...
git add .

echo [STEP] Creating initial commit...
git commit -m "🎮 Initial commit: Complete Games Apps Collection

📁 Features:
- 5 Fully Functional Games
- Professional Landing Page
- Investor Presentation
- Comprehensive Documentation
- Responsive Design
- Modern Web Technologies

🎮 Games Included:
- Zombie Plant Defenders (Tower Defense)
- Clumsy Cat Chaos (Physics Puzzle)
- Office Prank Wars (Multiplayer Strategy)
- Dance Battle Seniors (Rhythm Game)
- Food Fight Frenzy (Action Arcade)

🚀 Ready for GitHub Pages deployment!"

echo [INFO] Files committed ✓

REM Check if remote already exists
git remote get-url origin >nul 2>&1
if %errorlevel% equ 0 (
    echo [WARNING] Remote 'origin' already exists
    set /p UPDATE_REMOTE="[STEP] Do you want to update the remote URL? (y/n): "
    
    if /i "%UPDATE_REMOTE%"=="y" (
        git remote set-url origin "https://github.com/%GITHUB_USERNAME%/%REPO_NAME%.git"
        echo [INFO] Remote URL updated ✓
    )
) else (
    echo [STEP] Adding remote repository...
    git remote add origin "https://github.com/%GITHUB_USERNAME%/%REPO_NAME%.git"
    echo [INFO] Remote added ✓
)

REM Create GitHub repository (if it doesn't exist)
echo.
echo [STEP] Creating GitHub repository...
echo [WARNING] Please make sure you have created the repository on GitHub first!
echo [WARNING] Repository should be PUBLIC for GitHub Pages to work
echo [WARNING] Repository name should be: %REPO_NAME%
echo.
echo [STEP] Press Enter to continue, or Ctrl+C to cancel...
pause

REM Push to GitHub
echo [STEP] Pushing to GitHub...
git push -u origin main

if %errorlevel% equ 0 (
    echo [INFO] Successfully pushed to GitHub ✓
) else (
    echo [ERROR] Failed to push to GitHub
    echo [WARNING] Please check your GitHub credentials and repository URL
    pause
    exit /b 1
)

REM Display success message and next steps
echo.
echo 🎉 SUCCESS! Your games have been uploaded to GitHub!
echo.
echo [STEP] Next Steps:
echo 1. Go to: https://github.com/%GITHUB_USERNAME%/%REPO_NAME%
echo 2. Click on 'Settings' tab
echo 3. Scroll down to 'Pages' section
echo 4. Under 'Build and deployment', select 'Deploy from a branch'
echo 5. Source: 'Deploy from a branch'
echo 6. Branch: 'main'
echo 7. Folder: '/ (root)'
echo 8. Click 'Save'
echo.
echo [STEP] Your live website URLs will be:
echo 🌐 Main Site: https://%GITHUB_USERNAME%.github.io/%REPO_NAME%/
echo 🎮 Game 1: https://%GITHUB_USERNAME%.github.io/%REPO_NAME%/Game%201/
echo 🎮 Game 2: https://%GITHUB_USERNAME%.github.io/%REPO_NAME%/Game%202/
echo 🎮 Game 3: https://%GITHUB_USERNAME%.github.io/%REPO_NAME%/Game%203/
echo 🎮 Game 4: https://%GITHUB_USERNAME%.github.io/%REPO_NAME%/Game%204/
echo 🎮 Game 5: https://%GITHUB_USERNAME%.github.io/%REPO_NAME%/Game%205/
echo 💰 Investor Pitch: https://%GITHUB_USERNAME%.github.io/%REPO_NAME%/investor-presentation.html
echo.
echo [INFO] Deployment script completed successfully! 🚀
echo.
pause