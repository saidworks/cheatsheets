# JetBrains AI Assistant & Junie for Spring (IntelliJ IDEA) and .NET (Rider) Development

---

## ✅ Installation & Activation  
- Install **AI Assistant** (and optionally **Junie**) via **Settings → Plugins → Marketplace** or from the AI widget in the toolbar. Available in IntelliJ IDEA and Rider (Junie only in IntelliJ) :contentReference[oaicite:0]{index=0}.  
- Sign in with a JetBrains account to get a 30-day AI Pro trial; subsequent tiers (Free, Pro, Ultimate) offer increasing cloud usage quotas :contentReference[oaicite:1]{index=1}.

---

## ⚙️ Offline Mode & Local LLM Fallback  
1. Open the AI widget → **Offline Mode → Set Up Models** (or Settings → Tools → AI Assistant → Models) :contentReference[oaicite:2]{index=2}.  
2. Select Ollama or LM Studio, enter your local server URL, test connection, and assign models for **“Core”** (chat/generation) and **“Instant helpers”** (autocomplete) :contentReference[oaicite:3]{index=3}.  
3. Enable Offline Mode. Cloud LLM usage halts, while supported AI features fall back to local LLMs :contentReference[oaicite:4]{index=4}.  
> 🔒 *Note: Junie and multi-file edits remain unavailable in Offline Mode* :contentReference[oaicite:5]{index=5}.

---

## 🚀 Java Spring in IntelliJ IDEA  

### Spring Boot App Scaffolding  
- Use the **“Build a Spring Boot App with AI Assistant”** guide: create a new project, add a commented prompt, press **Enter**, and accept suggested controller code with **Tab** :contentReference[oaicite:6]{index=6}.  
- Example prompt:
  ```java
  // Create a Java web rest controller for a /hello endpoint with name param defaulting to "World"
````

AI suggests:

```java
@RestController
public class HomeController {
    @GetMapping("/hello")
    public String hello(@RequestParam(defaultValue="World") String name) {
        return "Hello " + name;
    }
}
```

Accept with Tab ([YouTrack][1]).

### Unit Test Generation

* Place caret inside a method, press **Alt+Enter → AI Actions → Generate Unit Tests**. AI opens a diff with generated JUnit tests ([JetBrains][2]).

### Documentation Generation

* Press **Alt+Enter → AI Actions → Write Documentation** to auto-generate Javadoc or XML comments ([JetBrains][3]).

### In-Editor Code Generation

* Use **AI Actions → Generate Code** or `Ctrl+\` (Win/Linux) to prompt AI. AI provides a diff in editor; accept with **Accept all** ([JetBrains][4]).

---

## 🛡 .NET (ASP.NET & Blazor) in Rider

### Entity Framework & Controllers

* Describe a database entity or controller in chat or comments, and select **AI Actions → Generate Code** to scaffolding C# classes, controllers, and CRUD operations.

### Unit Tests & Blazor Components

* Use **Alt+Enter → AI Actions → Generate Unit Tests**. AI generates NUnit/xUnit tests for selected C# methods ([The JetBrains Blog][5], [JetBrains][6]).
* For Blazor, prompt AI via chat (e.g., “Generate a Blazor component listing Products with paging”) to produce `.razor` code.

### Documentation

* Use **Alt+Enter → AI Actions → Write Documentation** to generate XML summary comments in C# ([JetBrains][7]).

---

## 💡 Junie Agent & Coding Guidelines (IntelliJ Only)

* **Junie** is available in IntelliJ IDEA with AI Pro for automated multi-step tasks based on `.junie/guidelines.md` ([JetBrains][8]).
* Example guidelines file:

  ```markdown
  * Use constructor injection
  * Return ResponseEntity with proper status codes
  * Validate with @Valid and meaningful errors
  ```

  Junie adheres to these standards during code generation ([The JetBrains Blog][9]).

---

## 🌐 Azure Integration Tips

### App Services & Debugging

* Install **Azure Toolkit** plugin. Rider supports remote debugging of Azure Web Apps and Functions ([Reddit][10]).
* Use `dotnet publish` and Azure run/debug configurations to deploy directly from IDE.

### Azure SQL & EF Core

* Use **Database Tools** to connect via *New Data Source → Azure SQL Database* in IntelliJ and Rider ([JetBrains][3], [JetBrains][7]).
* Scaffold EF models using chat or prompts: “Generate EF Core model for `Customer` table”.

### Azure Pipelines & CLI

* Connect to Azure Repos and manage pull requests via IDE. Use `az webapp up` and `dotnet ef migrations` from integrated terminal. Rider supports `.env` for managing connection strings ([JetBrains][3], [JetBrains][7]).

---

## ✅ Summary

* **Install** AI Assistant (+ Junie) via toolbar or plugin manager.
* **Activate trials/licenses** and choose Offline or cloud mode as needed.
* Use **Offline Mode** with local LLMs (Ollama/LM Studio) for offline availability.
* In **IntelliJ**, AI Assistant + Junie streamline Spring Boot development: scaffolding, docs, tests, multi-step tasks.
* In **Rider**, AI boosts EF scaffolding, Blazor components, unit test generation, and documentation.
* Integrate with **Azure** for remote deployment, database access, and CI/CD—all supported by IDE plugins.
* Keep coding consistent using `.junie/guidelines.md` for structured, idiomatic output.

JetBrains AI tools seamlessly embed into your IDE workflow, accelerating both Java Spring and .NET development with smart, context-aware assistance.


[1]: https://youtrack.jetbrains.com/projects/LLM/issues/LLM-17276/Cant-use-Junie-in-offline-mode-even-with-Active-Subscription?utm_source=chatgpt.com "Can't use Junie in offline mode even with Active Subscription"
[2]: https://www.jetbrains.com/help/ai-assistant/generate-tests-with-ai.html?utm_source=chatgpt.com "Generate tests | AI Assistant Documentation - JetBrains"
[3]: https://www.jetbrains.com/guide/tags/aia/?utm_source=chatgpt.com "AI - JetBrains Guide"
[4]: https://www.jetbrains.com/guide/ai/tips/generate-code/?utm_source=chatgpt.com "Generate code with AI Assistant - JetBrains Guide"
[5]: https://blog.jetbrains.com/dotnet/2024/03/13/generate-unit-tests-using-ai/?utm_source=chatgpt.com "Generate Unit Tests Using AI Assistant | The .NET Tools Blog"
[6]: https://www.jetbrains.com/guide/ai/links/generate-tests-using-ai-assistant/?utm_source=chatgpt.com "Generate Unit Tests Using AI Assistant - JetBrains Guide"
[7]: https://www.jetbrains.com/guide/tags/ai/?utm_source=chatgpt.com "Artificial Intelligence - JetBrains Guide"
[8]: https://lp.jetbrains.com/ai-ides-faq/?utm_source=chatgpt.com "JetBrains AI FAQ"
[9]: https://blog.jetbrains.com/idea/2025/05/coding-guidelines-for-your-ai-agents/?utm_source=chatgpt.com "Coding Guidelines for Your AI Agents | The IntelliJ IDEA Blog"
[10]: https://www.reddit.com/r/Jetbrains/comments/1k40n9s/the_offline_mode_for_ai_assistant_seems_to_still/?utm_source=chatgpt.com "the \"offline\" mode for AI assistant seems to still require you ... - Reddit"
