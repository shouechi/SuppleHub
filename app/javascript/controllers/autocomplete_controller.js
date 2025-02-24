import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }
  static targets = ["results"]

  connect() {
    // 初期状態では非表示
    this.resultsTarget.style.display = 'none';
  }

  search(event) {
    const query = event.target.value;

    // 検索フィールドが空の場合は結果を非表示
    if (!query.trim()) {
      this.resultsTarget.style.display = 'none';
      return;
    }

    const url = `${this.urlValue}?q[effect_or_side_effect_cont]=${encodeURIComponent(query)}`;

    fetch(url)
      .then(response => response.json())
      .then(data => {
        this.updateResults(data);
      })
      .catch(error => console.error('Error fetching autocomplete data:', error));
  }

  updateResults(data) {
    this.resultsTarget.innerHTML = '';

    // データがある場合のみ表示
    if (data.length > 0) {
      data.forEach(item => {
        const li = document.createElement('li');
        const a = document.createElement('a');
        a.textContent = item.effect || item.side_effect;
        a.classList.add('hover:bg-base-200');
        a.addEventListener('click', (e) => {
          e.preventDefault();
          this.selectResult(item);
        });
        li.appendChild(a);
        this.resultsTarget.appendChild(li);
      });
      this.resultsTarget.style.display = 'block';
    } else {
      this.resultsTarget.style.display = 'none';
    }
  }

  selectResult(item) {
    this.element.querySelector('input').value = item.effect || item.side_effect;
    this.resultsTarget.style.display = 'none';
  }

  // クリックイベントのハンドラを追加
  clickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.resultsTarget.style.display = 'none';
    }
  }
}