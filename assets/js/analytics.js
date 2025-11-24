class GameAnalytics {
  constructor(gameId) {
    this.gameId = gameId;
    this.session = { start: Date.now(), events: [] };
  }

  track(event, data = {}) {
    this.session.events.push({
      event,
      data,
      timestamp: Date.now()
    });
  }

  endSession(finalScore) {
    const duration = Date.now() - this.session.start;
    const summary = {
      gameId: this.gameId,
      duration,
      score: finalScore,
      events: this.session.events.length,
      date: new Date().toISOString()
    };

    const key = `analytics_${this.gameId}`;
    const history = JSON.parse(localStorage.getItem(key) || '[]');
    history.push(summary);
    localStorage.setItem(key, JSON.stringify(history.slice(-100)));
    
    return summary;
  }

  getStats() {
    const key = `analytics_${this.gameId}`;
    const history = JSON.parse(localStorage.getItem(key) || '[]');
    
    if (history.length === 0) return null;

    return {
      totalGames: history.length,
      avgScore: history.reduce((a, b) => a + b.score, 0) / history.length,
      avgDuration: history.reduce((a, b) => a + b.duration, 0) / history.length,
      bestScore: Math.max(...history.map(h => h.score)),
      totalPlayTime: history.reduce((a, b) => a + b.duration, 0)
    };
  }

  getInsights() {
    const stats = this.getStats();
    if (!stats) return [];

    const insights = [];
    const hours = stats.totalPlayTime / 3600000;
    
    if (hours > 1) insights.push(`🎮 ${hours.toFixed(1)}h total playtime`);
    if (stats.totalGames > 10) insights.push(`🏆 ${stats.totalGames} games played`);
    if (stats.avgScore > 1000) insights.push(`⭐ Expert level player`);
    
    return insights;
  }
}

window.GameAnalytics = GameAnalytics;
