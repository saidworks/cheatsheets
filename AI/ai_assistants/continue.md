# Continue VS Code Extension with Local LLMs for Java Spring Development

## 1. Installing and Configuring Continue

Install the **Continue** extension from the VS Code Marketplace. In VS Code’s Extensions pane (`Ctrl+Shift+X`), search for **“Continue”** (ID: `continue.continue`) and click **Install**. After installation, the Continue icon appears on the sidebar. You may optionally sign in to Continue’s hub (for shared assistants) or skip sign-in to use it entirely with local models.

Next, configure Continue to use your local LLM. Open Continue’s settings (click the gear icon or open the command palette) and edit the configuration (`config.json` or `.continue/config.yml`). Add an entry pointing to your local model server. For example, if using Ollama, you might add to `config.json`:

```json
{
  "models": [
    {
      "title": "MyLocalLLM",
      "provider": "ollama",
      "model": "mistral:latest",
      "apiBase": "http://localhost:11434",
      "systemMessage": "You are an expert Java developer. Give clear, concise answers."
    }
  ]
}
```

This tells Continue to connect to the Ollama server on `localhost:11434` and use the Mistral model. (Exxact Corp provides a similar example configuring **Deepseek R1 Distill Qwen 32B** via Ollama.) After saving the config and reloading the extension, select your model in the Continue panel (click the model selector in the bottom-left of the Continue pane).

## 2. Connecting Local LLMs (Model Control Panel)

Run your local LLM (e.g. via Ollama, LM Studio or Docker). For instance, install Ollama on your machine and pull a model:

```bash
docker run -d --restart always -p 11434:11434 ollama/ollama
docker exec -it <OLLAMA_CONTAINER> ollama pull mistral:latest
```

With the model running locally, Continue will send requests to it. In the Continue **Model Control Panel** (the extension’s side panel), ensure the active model is set correctly (e.g. “Mistral” in our example). Omar Alva’s walkthrough shows adding a Mistral model and then clicking the bottom-left model selector to activate it. You can add multiple providers or models (e.g. a smaller model for autocomplete) in the same config.

* **Model Roles**: You can assign roles in config (chat, edit, autocomplete) so Continue uses models appropriately (e.g. one model for chat, another for inline completions). The `.continue/config.yml` format may also be used (as in Sagar Ingalagi’s example) to set roles and models systematically.

## 3. Recommended Local Models (6 GB GPU, 32 GB RAM)

On a system with \~32 GB RAM and a 6 GB NVIDIA GPU, medium-sized open models (\~5–8B parameters) are a good fit. For example:

* **Mistral 7B** (≈4.1 GB VRAM) – fits comfortably on 6 GB.
* **Llama 3.1 (8B)** (≈4.9 GB VRAM) – also fits on 6 GB.
* **Qwen2.5-Coder 7B** (≈4.7 GB VRAM) – a code-specialized model recommended for coding tasks.
* **Qwen2.5 7B** (≈4.7 GB) – general coding model (GTX 1660 6 GB recommended).
* **Qwen1.5 7B** (≈4.5 GB) – fits on 6 GB and is optimized for smaller footprint.
* **Code Llama 7B** (≈3.8 GB) – a language model optimized for code.
* **LLaVA 7B** (≈4.7 GB) – a vision-language model (fits 6 GB) that can also handle code.

These models can run at 4-bit precision (Q4) to reduce VRAM use. In practice, models up to \~9B may run on 6 GB with heavy quantization, but 7–8B is safer. (By contrast, truly large models like 14B+ generally require ≥16 GB VRAM.) For Java/Spring development, choose a model known to handle code well (e.g. Qwen2.5-Coder, CodeLlama) so that IDE tasks like autocompletion and analysis work effectively.

## 4. Productivity Tips for Java Spring Development

* **Use Continue Chat for Design and Explanation:** In the Continue side panel, ask natural-language questions. For example, highlight a Spring controller method and type “What does this do?” or “How can I extend this to handle errors?” Continue is designed for tasks like *explaining logic, generating boilerplate, refactoring code, and creating tests*, all of which accelerate Spring development.
* **Inline Editing (Ctrl+I):** In any code file, select code and press **Ctrl+I** to open a prompt. You can then instruct Continue to modify or generate code in place. For instance, select a TODO comment or an empty method body and press Ctrl+I, then type “implement this Spring Data repository method to find books by title” and accept the suggestion.
* **Tab Autocomplete:** As you type code, Continue offers autocompletions in gray. Press **Tab** to accept a suggestion (for example, while writing a Spring bean or loop). If the inline completion stalls, just use **Ctrl+I** and type a prompt (e.g. “continue the code”) to have the assistant finish it.
* **Share Context:** Use the **Add Context** button in the chat UI to feed files or folders into the prompt. For example, add your Spring `application.properties` or SQL schema files so the model knows your environment. Also click **Use codebase** in the prompt input to let Continue vectorize your entire project; it will then automatically include relevant snippets when you ask questions like “Where is UserRepository used?”. This is invaluable for large Spring projects.
* **Custom Slash Commands:** Define your own shortcuts. For example, you can create a slash command for generating JPA entity classes or configuration. See examples below.

## 5. Prompt and Custom Command Examples

* **Unit Test Generation:** Define a custom command named `test`. In your Continue config (`config.json` or `.continue/config.json`), add:

  ```json
  "customCommands": [
    {
      "name": "test",
      "prompt": "{{{ input }}}\n\nWrite a comprehensive set of JUnit tests for the selected code, including setup, assertions, and edge cases.",
      "description": "Generate unit tests for the highlighted code"
    }
  ]
  ```

  With this, highlighting a Spring service method and triggering `/test` will make Continue output a full suite of tests.

* **Documentation (Javadoc):** Create a prompt file at `.continue/rules/javadoc-prompt.md` with YAML frontmatter (see Continue prompts format). For example:

  ```markdown
  ---
  name: Write Javadoc
  alwaysApply: false
  ---
  Generate Javadoc comments for the selected Java method, describing its purpose, parameters, and return value.
  ```

  Then type `/Write Javadoc` in the chat to apply this prompt to any method. (The structure above follows the official Continue prompt example.)

* **Code Generation:** In chat or via Ctrl+I, you might use prompts like:

  > **Prompt:** *“Create a Spring Boot REST controller for entity `Book` with `GET /books` and `POST /books` endpoints, using constructor injection.”*
  > The model will generate the Java class code accordingly.

Each prompt can incorporate highlighted code or file context (using `{{{ input }}}` as shown above). By combining Continue’s chat, autocomplete, edit mode, and custom commands, you can quickly scaffold Spring components (controllers, services, repositories), generate unit tests, and write documentation – all running fully on your local LLM.

**Sources:** Official Continue docs and guides; examples from Exxact Corp and community tutorials.
