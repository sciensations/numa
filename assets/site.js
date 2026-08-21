(() => {
  const form = document.querySelector("#catalog-filters");
  const catalog = document.querySelector("#exercise-catalog");
  if (!form || !catalog) return;

  const cards = [...catalog.querySelectorAll(".catalog-card")];
  const count = document.querySelector("#result-count");
  const empty = document.querySelector("#no-results");
  const controls = {
    q: form.querySelector("[name=q]"),
    topic: form.querySelector("[name=topic]"),
    min: form.querySelector("[name=min]"),
    max: form.querySelector("[name=max]"),
    source: form.querySelector("[name=source]"),
    selection: form.querySelector("[name=selection]"),
  };

  const normalized = (value) => value
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLocaleLowerCase("fr");

  const tokens = (value) => value.split(/\s+/).filter(Boolean);

  const apply = () => {
    const query = normalized(controls.q.value.trim());
    let minimum = Number(controls.min.value || 1);
    let maximum = Number(controls.max.value || 5);
    if (minimum > maximum) {
      [minimum, maximum] = [maximum, minimum];
      controls.min.value = String(minimum);
      controls.max.value = String(maximum);
    }

    let visible = 0;
    for (const card of cards) {
      const difficulty = Number(card.dataset.difficulty);
      const matches = (!query || normalized(card.textContent).includes(query))
        && (!controls.topic.value || tokens(card.dataset.topics).includes(controls.topic.value))
        && difficulty >= minimum
        && difficulty <= maximum
        && (!controls.source.value || card.dataset.source === controls.source.value)
        && (!controls.selection.value || tokens(card.dataset.selections).includes(controls.selection.value));
      card.hidden = !matches;
      if (matches) visible += 1;
    }

    count.textContent = `${visible} exercice${visible === 1 ? "" : "s"}`;
    empty.hidden = visible !== 0;

    const params = new URLSearchParams();
    if (controls.q.value.trim()) params.set("q", controls.q.value.trim());
    if (controls.topic.value) params.set("topic", controls.topic.value);
    if (minimum !== 1) params.set("min", String(minimum));
    if (maximum !== 5) params.set("max", String(maximum));
    if (controls.source.value) params.set("source", controls.source.value);
    if (controls.selection.value) params.set("selection", controls.selection.value);
    const suffix = params.size ? `?${params}` : location.pathname;
    history.replaceState(null, "", suffix);
  };

  const params = new URLSearchParams(location.search);
  for (const [name, control] of Object.entries(controls)) {
    if (params.has(name)) control.value = params.get(name);
  }

  form.addEventListener("input", apply);
  form.addEventListener("change", apply);
  form.addEventListener("reset", () => requestAnimationFrame(apply));
  apply();
})();
