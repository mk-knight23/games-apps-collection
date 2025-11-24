class GameUtils {
  static initTheme() {
    const theme = localStorage.getItem('theme') || 'dark';
    document.documentElement.setAttribute('data-theme', theme);
    return theme;
  }

  static toggleTheme() {
    const current = document.documentElement.getAttribute('data-theme');
    const next = current === 'dark' ? 'light' : 'dark';
    document.documentElement.setAttribute('data-theme', next);
    localStorage.setItem('theme', next);
    return next;
  }

  static createParticles(x, y, color, count = 10) {
    const particles = [];
    for (let i = 0; i < count; i++) {
      particles.push({
        x, y,
        vx: (Math.random() - 0.5) * 8,
        vy: (Math.random() - 0.5) * 8,
        life: 1,
        color,
        size: Math.random() * 4 + 2
      });
    }
    return particles;
  }

  static updateParticles(particles) {
    return particles.filter(p => {
      p.x += p.vx;
      p.y += p.vy;
      p.vy += 0.2;
      p.life -= 0.02;
      return p.life > 0;
    });
  }

  static drawParticles(ctx, particles) {
    particles.forEach(p => {
      ctx.globalAlpha = p.life;
      ctx.fillStyle = p.color;
      ctx.beginPath();
      ctx.arc(p.x, p.y, p.size, 0, Math.PI * 2);
      ctx.fill();
    });
    ctx.globalAlpha = 1;
  }

  static saveScore(gameId, score, data = {}) {
    const key = `scores_${gameId}`;
    const scores = JSON.parse(localStorage.getItem(key) || '[]');
    scores.push({ score, ...data, date: new Date().toISOString() });
    scores.sort((a, b) => b.score - a.score);
    localStorage.setItem(key, JSON.stringify(scores.slice(0, 100)));
  }

  static getLeaderboard(gameId, limit = 10) {
    const key = `scores_${gameId}`;
    const scores = JSON.parse(localStorage.getItem(key) || '[]');
    return scores.slice(0, limit);
  }

  static checkAchievement(gameId, type, value) {
    const achievements = {
      first_win: { name: "First Victory", condition: v => v === 1 },
      score_1000: { name: "Score Master", condition: v => v >= 1000 },
      speed_demon: { name: "Speed Demon", condition: v => v < 60 },
      perfectionist: { name: "Perfectionist", condition: v => v === 0 }
    };

    const key = `achievements_${gameId}`;
    const unlocked = JSON.parse(localStorage.getItem(key) || '{}');
    
    if (achievements[type] && !unlocked[type] && achievements[type].condition(value)) {
      unlocked[type] = { name: achievements[type].name, date: Date.now() };
      localStorage.setItem(key, JSON.stringify(unlocked));
      return achievements[type].name;
    }
    return null;
  }

  static vibrate(pattern = [100]) {
    if ('vibrate' in navigator) navigator.vibrate(pattern);
  }

  static playSound(frequency, duration = 100) {
    if (!window.audioContext) window.audioContext = new (window.AudioContext || window.webkitAudioContext)();
    const oscillator = window.audioContext.createOscillator();
    const gainNode = window.audioContext.createGain();
    oscillator.connect(gainNode);
    gainNode.connect(window.audioContext.destination);
    oscillator.frequency.value = frequency;
    oscillator.type = 'sine';
    gainNode.gain.setValueAtTime(0.3, window.audioContext.currentTime);
    gainNode.gain.exponentialRampToValueAtTime(0.01, window.audioContext.currentTime + duration / 1000);
    oscillator.start();
    oscillator.stop(window.audioContext.currentTime + duration / 1000);
  }
}

window.GameUtils = GameUtils;
