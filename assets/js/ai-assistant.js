class AIAssistant {
  constructor() {
    this.active = false;
    this.difficulty = 'medium';
    this.playerStats = { wins: 0, losses: 0, avgScore: 0 };
  }

  analyzeDifficulty(score, time, mistakes) {
    const performance = score / (time + mistakes * 10);
    if (performance > 0.8) return 'hard';
    if (performance < 0.3) return 'easy';
    return 'medium';
  }

  getHint(gameState) {
    const hints = {
      low_health: "💡 Your health is low! Focus on defense.",
      high_score: "🎯 Great job! Keep the momentum going!",
      combo_available: "⚡ Combo ready! Chain your moves!",
      resource_low: "⚠️ Resources running low. Collect more!",
      enemy_pattern: "🔍 Enemy pattern detected. Prepare defense!"
    };
    
    if (gameState.health < 30) return hints.low_health;
    if (gameState.score > 1000) return hints.high_score;
    if (gameState.combo >= 3) return hints.combo_available;
    if (gameState.resources < 20) return hints.resource_low;
    return hints.enemy_pattern;
  }

  predictNextMove(history) {
    if (history.length < 3) return null;
    const recent = history.slice(-3);
    const pattern = recent.every(m => m.type === 'attack') ? 'aggressive' : 'defensive';
    return pattern === 'aggressive' ? 'defend' : 'attack';
  }

  generateAIOpponent(difficulty) {
    const configs = {
      easy: { speed: 0.5, accuracy: 0.6, reaction: 800 },
      medium: { speed: 0.8, accuracy: 0.75, reaction: 500 },
      hard: { speed: 1.2, accuracy: 0.9, reaction: 200 }
    };
    return configs[difficulty] || configs.medium;
  }

  saveProgress(gameId, data) {
    const key = `ai_progress_${gameId}`;
    const existing = JSON.parse(localStorage.getItem(key) || '[]');
    existing.push({ ...data, timestamp: Date.now() });
    localStorage.setItem(key, JSON.stringify(existing.slice(-50)));
  }

  getRecommendation(gameId) {
    const key = `ai_progress_${gameId}`;
    const history = JSON.parse(localStorage.getItem(key) || '[]');
    if (history.length < 5) return "Keep playing to unlock AI insights!";
    
    const avgScore = history.reduce((a, b) => a + b.score, 0) / history.length;
    const trend = history.slice(-3).every((h, i, arr) => i === 0 || h.score > arr[i-1].score);
    
    if (trend) return "📈 You're improving! Try harder difficulty.";
    if (avgScore < 500) return "💪 Practice makes perfect! Focus on basics.";
    return "🎮 You're doing great! Challenge yourself!";
  }
}

window.AIAssistant = AIAssistant;
