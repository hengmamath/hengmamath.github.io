/* Show definitions only in the dialog; retain an on-page fallback without JavaScript. */
(() => {
  const guide = document.querySelector('.ai-use-guide-content');
  if (!guide || typeof HTMLDialogElement === 'undefined') return;

  const dialog = document.createElement('dialog');
  if (typeof dialog.showModal !== 'function') return;
  dialog.id = 'ai-use-dialog';
  dialog.className = 'ai-use-dialog';
  dialog.setAttribute('aria-labelledby', 'ai-use-dialog-title');

  const toolbar = document.createElement('div');
  toolbar.className = 'ai-use-dialog-toolbar';
  const close = document.createElement('button');
  close.type = 'button';
  close.className = 'ai-use-close';
  close.textContent = 'Close';
  close.setAttribute('aria-label', 'Close AI use explanation');
  toolbar.append(close);

  const content = guide.cloneNode(true);
  content.querySelectorAll('[id]').forEach(node => node.removeAttribute('id'));
  const title = content.querySelector('h2');
  title.id = 'ai-use-dialog-title';
  toolbar.prepend(title);
  const note = document.createElement('p');
  note.className = 'ai-use-paper-note';
  note.hidden = true;
  content.querySelector('.ai-use-levels').before(note);
  dialog.append(toolbar, content);
  document.body.append(dialog);
  guide.closest('.ai-use-guide').hidden = true;

  let opener;
  document.querySelectorAll('a[data-ai-use]').forEach(link => {
    link.setAttribute('aria-haspopup', 'dialog');
    link.setAttribute('aria-controls', dialog.id);
    link.addEventListener('click', event => {
      if (event.ctrlKey || event.metaKey || event.shiftKey || event.altKey) return;
      event.preventDefault();
      opener = link;
      content.querySelectorAll('[data-ai-level]').forEach(row => {
        const selected = row.dataset.aiLevel === link.dataset.aiUse;
        row.classList.toggle('is-selected', selected);
        if (selected) row.setAttribute('aria-current', 'true');
        else row.removeAttribute('aria-current');
      });
      note.textContent = link.dataset.aiNote || '';
      note.hidden = !note.textContent;
      dialog.showModal();
      document.documentElement.classList.add('ai-use-modal-open');
      dialog.scrollTop = 0;
      close.focus({ preventScroll: true });
      const selected = content.querySelector('.is-selected');
      if (selected) selected.scrollIntoView({ block: 'nearest' });
    });
  });

  close.addEventListener('click', () => dialog.close());
  dialog.addEventListener('click', event => {
    const bounds = dialog.getBoundingClientRect();
    if (event.target === dialog && (event.clientX < bounds.left || event.clientX > bounds.right || event.clientY < bounds.top || event.clientY > bounds.bottom)) dialog.close();
  });
  dialog.addEventListener('close', () => {
    document.documentElement.classList.remove('ai-use-modal-open');
    if (opener) opener.focus({ preventScroll: true });
  });
})();
