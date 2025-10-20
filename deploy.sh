#!/bin/bash

# 🚀 Games Apps Collection - GitHub Deployment Script
# This script automates the process of uploading games to GitHub and enabling GitHub Pages

echo "🎮 Games Apps Collection - GitHub Deployment Script"
echo "=================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

# Check if Git is installed
if ! command -v git &> /dev/null; then
    print_error "Git is not installed. Please install Git first."
    echo "Visit: https://git-scm.com/downloads"
    exit 1
fi

print_status "Git is installed ✓"

# Check if we're in the right directory
if [ ! -f "index.html" ]; then
    print_error "Please run this script from the Games Apps directory"
    exit 1
fi

print_status "Directory check passed ✓"

# Ask for GitHub username
echo ""
print_step "Please enter your GitHub username:"
read -p "GitHub Username: " GITHUB_USERNAME

if [ -z "$GITHUB_USERNAME" ]; then
    print_error "GitHub username is required"
    exit 1
fi

print_status "Using GitHub username: $GITHUB_USERNAME"

# Ask for repository name
echo ""
print_step "Repository name (default: games-apps-collection):"
read -p "Repository Name: " REPO_NAME

if [ -z "$REPO_NAME" ]; then
    REPO_NAME="games-apps-collection"
fi

print_status "Using repository name: $REPO_NAME"

# Initialize Git repository if not already initialized
if [ ! -d ".git" ]; then
    print_step "Initializing Git repository..."
    git init
    print_status "Git repository initialized ✓"
else
    print_status "Git repository already exists ✓"
fi

# Configure Git if not configured
if [ -z "$(git config user.name)" ]; then
    print_step "Please enter your Git user name:"
    read -p "Git User Name: " GIT_NAME
    git config user.name "$GIT_NAME"
fi

if [ -z "$(git config user.email)" ]; then
    print_step "Please enter your Git user email:"
    read -p "Git User Email: " GIT_EMAIL
    git config user.email "$GIT_EMAIL"
fi

# Add all files and commit
print_step "Adding files to Git..."
git add .

print_step "Creating initial commit..."
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

print_status "Files committed ✓"

# Check if remote already exists
if git remote get-url origin 2>/dev/null; then
    print_warning "Remote 'origin' already exists"
    print_step "Do you want to update the remote URL? (y/n)"
    read -p "Update remote? (y/n): " UPDATE_REMOTE
    
    if [ "$UPDATE_REMOTE" = "y" ] || [ "$UPDATE_REMOTE" = "Y" ]; then
        git remote set-url origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
        print_status "Remote URL updated ✓"
    fi
else
    print_step "Adding remote repository..."
    git remote add origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
    print_status "Remote added ✓"
fi

# Create GitHub repository (if it doesn't exist)
echo ""
print_step "Creating GitHub repository..."
print_warning "Please make sure you have created the repository on GitHub first!"
print_warning "Repository should be PUBLIC for GitHub Pages to work"
print_warning "Repository name should be: $REPO_NAME"
echo ""
print_step "Press Enter to continue, or Ctrl+C to cancel..."
read

# Push to GitHub
print_step "Pushing to GitHub..."
git push -u origin main

if [ $? -eq 0 ]; then
    print_status "Successfully pushed to GitHub ✓"
else
    print_error "Failed to push to GitHub"
    print_warning "Please check your GitHub credentials and repository URL"
    exit 1
fi

# Display success message and next steps
echo ""
echo "🎉 SUCCESS! Your games have been uploaded to GitHub!"
echo ""
print_step "Next Steps:"
echo "1. Go to: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo "2. Click on 'Settings' tab"
echo "3. Scroll down to 'Pages' section"
echo "4. Under 'Build and deployment', select 'Deploy from a branch'"
echo "5. Source: 'Deploy from a branch'"
echo "6. Branch: 'main'"
echo "7. Folder: '/ (root)'"
echo "8. Click 'Save'"
echo ""
print_step "Your live website URLs will be:"
echo "🌐 Main Site: https://$GITHUB_USERNAME.github.io/$REPO_NAME/"
echo "🎮 Game 1: https://$GITHUB_USERNAME.github.io/$REPO_NAME/Game%201/"
echo "🎮 Game 2: https://$GITHUB_USERNAME.github.io/$REPO_NAME/Game%202/"
echo "🎮 Game 3: https://$GITHUB_USERNAME.github.io/$REPO_NAME/Game%203/"
echo "🎮 Game 4: https://$GITHUB_USERNAME.github.io/$REPO_NAME/Game%204/"
echo "🎮 Game 5: https://$GITHUB_USERNAME.github.io/$REPO_NAME/Game%205/"
echo "💰 Investor Pitch: https://$GITHUB_USERNAME.github.io/$REPO_NAME/investor-presentation.html"
echo ""
print_status "Deployment script completed successfully! 🚀"