---
uuid: 0c957dd0-1a68-11f0-b65e-2d145289379e
tags:
  - note
  - blog
share: "true"
categories:
  - LLM
title: Awesome-LLM
date: 2024-11-15,09:52
comments: true
---

## [Awesome-LLM](https://github.com/Hannibal046/Awesome-LLM)

![](assets/images/8cdaceb60a9120edd71da31eebe343cd_MD5.gif)

🔥 Large Language Models (LLM) have taken the ~~NLP community~~ ~~AI community~~ **the Whole World** by storm. Here is a curated list of papers about large language models, especially relating to ChatGPT. It also contains frameworks for LLM training, tools to deploy LLM, courses and tutorials about LLM and all publicly available LLM checkpoints and APIs.

- [Awesome-LLM](https://github.com/Hannibal046/Awesome-LLM#awesome-llm-)
  - [Milestone Papers](https://github.com/Hannibal046/Awesome-LLM#milestone-papers)
  - [Other Papers](https://github.com/Hannibal046/Awesome-LLM#other-papers)
  - [LLM Leaderboard](https://github.com/Hannibal046/Awesome-LLM#llm-leaderboard)
  - [Open LLM](https://github.com/Hannibal046/Awesome-LLM#open-llm)
  - [LLM Data](https://github.com/Hannibal046/Awesome-LLM#llm-data)
  - [LLM Evaluation](https://github.com/Hannibal046/Awesome-LLM#llm-evaluation)
  - [LLM Training Framework](https://github.com/Hannibal046/Awesome-LLM#llm-training-frameworks)
  - [LLM Deployment](https://github.com/Hannibal046/Awesome-LLM#llm-deployment)
  - [LLM Applications](https://github.com/Hannibal046/Awesome-LLM#llm-applications)
  - [LLM Books](https://github.com/Hannibal046/Awesome-LLM#llm-books)
  - [Great thoughts about LLM](https://github.com/Hannibal046/Awesome-LLM#great-thoughts-about-llm)
  - [Miscellaneous](https://github.com/Hannibal046/Awesome-LLM#miscellaneous)

## [Awesome-Chinese-LLM](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM)

整理开源的中文大语言模型，以规模较小、可私有化部署、训练成本较低的模型为主，包括底座模型，垂直领域微调及应用，数据集与教程等。

![](assets/images/3ece06e242551f2fe43c97c31346d50f_MD5.png)
自 ChatGPT 为代表的大语言模型（Large Language Model, LLM）出现以后，由于其惊人的类通用人工智能（AGI）的能力，掀起了新一轮自然语言处理领域的研究和应用的浪潮。尤其是以 ChatGLM、LLaMA 等平民玩家都能跑起来的较小规模的 LLM 开源之后，业界涌现了非常多基于 LLM 的二次微调或应用的案例。本项目旨在收集和梳理中文 LLM 相关的开源模型、应用、数据集及教程等资料，目前收录的资源已达 100+个！

- [目录](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#%E7%9B%AE%E5%BD%95)
  - [1. 模型](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#1-%E6%A8%A1%E5%9E%8B)
    - [1.1 文本 LLM 模型](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#11-%E6%96%87%E6%9C%ACllm%E6%A8%A1%E5%9E%8B)
    - [1.2 多模态 LLM 模型](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#12-%E5%A4%9A%E6%A8%A1%E6%80%81llm%E6%A8%A1%E5%9E%8B)
  - [2. 应用](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#2-%E5%BA%94%E7%94%A8)
    - [2.1 垂直领域微调](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#21-%E5%9E%82%E7%9B%B4%E9%A2%86%E5%9F%9F%E5%BE%AE%E8%B0%83)
      - [医疗](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#%E5%8C%BB%E7%96%97)
      - [法律](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#%E6%B3%95%E5%BE%8B)
      - [金融](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#%E9%87%91%E8%9E%8D)
      - [教育](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#%E6%95%99%E8%82%B2)
      - [科技](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#%E7%A7%91%E6%8A%80)
      - [电商](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#%E7%94%B5%E5%95%86)
      - [网络安全](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#%E7%BD%91%E7%BB%9C%E5%AE%89%E5%85%A8)
      - [农业](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#%E5%86%9C%E4%B8%9A)
    - [2.2 LangChain 应用](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#22-langchain%E5%BA%94%E7%94%A8)
    - [2.3 其他应用](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#23-%E5%85%B6%E4%BB%96%E5%BA%94%E7%94%A8)
  - [3. 数据集](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#3-%E6%95%B0%E6%8D%AE%E9%9B%86)
    - [预训练数据集](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#%E9%A2%84%E8%AE%AD%E7%BB%83%E6%95%B0%E6%8D%AE%E9%9B%86)
    - [SFT 数据集](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#sft%E6%95%B0%E6%8D%AE%E9%9B%86)
    - [偏好数据集](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#%E5%81%8F%E5%A5%BD%E6%95%B0%E6%8D%AE%E9%9B%86)
  - [4. LLM 训练微调框架](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#4-llm%E8%AE%AD%E7%BB%83%E5%BE%AE%E8%B0%83%E6%A1%86%E6%9E%B6)
  - [5. LLM 推理部署框架](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#5-llm%E6%8E%A8%E7%90%86%E9%83%A8%E7%BD%B2%E6%A1%86%E6%9E%B6)
  - [6. LLM 评测](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#6-llm%E8%AF%84%E6%B5%8B)
  - [7. LLM 教程](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#7-llm%E6%95%99%E7%A8%8B)
    - [LLM 基础知识](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#llm%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86)
    - [提示工程教程](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#%E6%8F%90%E7%A4%BA%E5%B7%A5%E7%A8%8B%E6%95%99%E7%A8%8B)
    - [LLM 应用教程](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#llm%E5%BA%94%E7%94%A8%E6%95%99%E7%A8%8B)
    - [LLM 实战教程](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#llm%E5%AE%9E%E6%88%98%E6%95%99%E7%A8%8B)
  - [8. 相关仓库](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#8-%E7%9B%B8%E5%85%B3%E4%BB%93%E5%BA%93)
- [Star History](https://github.com/HqWu-HITCS/Awesome-Chinese-LLM#star-history)

## [Awesome-LLMOps](https://github.com/tensorchord/Awesome-LLMOps)

An awesome & curated list of best LLMOps tools for developers。

- [Table of Contents](https://github.com/tensorchord/Awesome-LLMOps#table-of-contents)
- [Model](https://github.com/tensorchord/Awesome-LLMOps#model)
  - [Large Language Model](https://github.com/tensorchord/Awesome-LLMOps#large-language-model)
  - [CV Foundation Model](https://github.com/tensorchord/Awesome-LLMOps#cv-foundation-model)
  - [Audio Foundation Model](https://github.com/tensorchord/Awesome-LLMOps#audio-foundation-model)
- [Serving](https://github.com/tensorchord/Awesome-LLMOps#serving)
  - [Large Model Serving](https://github.com/tensorchord/Awesome-LLMOps#large-model-serving)
  - [Frameworks/Servers for Serving](https://github.com/tensorchord/Awesome-LLMOps#frameworksservers-for-serving)
  - [Observability](https://github.com/tensorchord/Awesome-LLMOps#observability)
- [Security](https://github.com/tensorchord/Awesome-LLMOps#security)
- [LLMOps](https://github.com/tensorchord/Awesome-LLMOps#llmops)
- [Search](https://github.com/tensorchord/Awesome-LLMOps#search)
  - [Vector search](https://github.com/tensorchord/Awesome-LLMOps#vector-search)
- [Code AI](https://github.com/tensorchord/Awesome-LLMOps#code-ai)
- [Training](https://github.com/tensorchord/Awesome-LLMOps#training)
  - [IDEs and Workspaces](https://github.com/tensorchord/Awesome-LLMOps#ides-and-workspaces)
  - [Foundation Model Fine Tuning](https://github.com/tensorchord/Awesome-LLMOps#foundation-model-fine-tuning)
  - [Frameworks for Training](https://github.com/tensorchord/Awesome-LLMOps#frameworks-for-training)
  - [Experiment Tracking](https://github.com/tensorchord/Awesome-LLMOps#experiment-tracking)
  - [Visualization](https://github.com/tensorchord/Awesome-LLMOps#visualization)
  - [Model Editing](https://github.com/tensorchord/Awesome-LLMOps#model-editing)
- [Data](https://github.com/tensorchord/Awesome-LLMOps#data)
  - [Data Management](https://github.com/tensorchord/Awesome-LLMOps#data-management)
  - [Data Storage](https://github.com/tensorchord/Awesome-LLMOps#data-storage)
  - [Data Tracking](https://github.com/tensorchord/Awesome-LLMOps#data-tracking)
  - [Feature Engineering](https://github.com/tensorchord/Awesome-LLMOps#feature-engineering)
  - [Data/Feature enrichment](https://github.com/tensorchord/Awesome-LLMOps#datafeature-enrichment)
- [Large Scale Deployment](https://github.com/tensorchord/Awesome-LLMOps#large-scale-deployment)
  - [ML Platforms](https://github.com/tensorchord/Awesome-LLMOps#ml-platforms)
  - [Workflow](https://github.com/tensorchord/Awesome-LLMOps#workflow)
  - [Scheduling](https://github.com/tensorchord/Awesome-LLMOps#scheduling)
  - [Model Management](https://github.com/tensorchord/Awesome-LLMOps#model-management)
- [Performance](https://github.com/tensorchord/Awesome-LLMOps#performance)
  - [ML Compiler](https://github.com/tensorchord/Awesome-LLMOps#ml-compiler)
  - [Profiling](https://github.com/tensorchord/Awesome-LLMOps#profiling)
- [AutoML](https://github.com/tensorchord/Awesome-LLMOps#automl)
- [Optimizations](https://github.com/tensorchord/Awesome-LLMOps#optimizations)
- [Federated ML](https://github.com/tensorchord/Awesome-LLMOps#federated-ml)
- [Awesome Lists](https://github.com/tensorchord/Awesome-LLMOps#awesome-lists)

## [awesome-LLMs-In-China](https://github.com/wgwang/awesome-LLMs-In-China)

中国大模型大全，全面收集有明确来源的大模型情况，包括机构、来源信息和分类等，随时更新。

旨在记录中国大模型发展情况，欢迎在**Issues**中提供提供**线索**和**素材**

使用数据请注明来源：**微信公众号：走向未来**  和  **仓库：[https://github.com/wgwang/awesome-LLMs-In-China](https://github.com/wgwang/awesome-LLMs-In-China)**

Awesome family related to LLMS includes:

- [https://github.com/wgwang/awesome-LLM-benchmarks](https://github.com/wgwang/awesome-LLM-benchmarks)
- [https://github.com/wgwang/awesome-LLMs-In-China](https://github.com/wgwang/awesome-LLMs-In-China)
- [https://github.com/wgwang/awesome-open-foundation-models](https://github.com/wgwang/awesome-open-foundation-models)

大模型相关的 Awesome 系列包括：

- 大模型评测数据集： [https://github.com/wgwang/awesome-LLM-benchmarks](https://github.com/wgwang/awesome-LLM-benchmarks)
- 中国大模型列表： [https://github.com/wgwang/awesome-LLMs-In-China](https://github.com/wgwang/awesome-LLMs-In-China)
- 开源开放基础大模型列表： [https://github.com/wgwang/awesome-open-foundation-models](https://github.com/wgwang/awesome-open-foundation-models)

## [awesome-LLM-resourses](https://github.com/WangRongsheng/awesome-LLM-resourses) ：★★★★☆

<font color="#ff0000">这个好</font>

全世界最好的 LLM 资料总结 | Summary of the world's best LLM resources.

- [数据 Data](https://github.com/WangRongsheng/awesome-LLM-resourses#%E6%95%B0%E6%8D%AE-Data)
- [微调 Fine-Tuning](https://github.com/WangRongsheng/awesome-LLM-resourses#%E5%BE%AE%E8%B0%83-Fine-Tuning)
- [推理 Inference](https://github.com/WangRongsheng/awesome-LLM-resourses#%E6%8E%A8%E7%90%86-Inference)
- [评估 Evaluation](https://github.com/WangRongsheng/awesome-LLM-resourses#%E8%AF%84%E4%BC%B0-Evaluation)
- [体验 Usage](https://github.com/WangRongsheng/awesome-LLM-resourses#%E4%BD%93%E9%AA%8C-Usage)
- [知识库 RAG](https://github.com/WangRongsheng/awesome-LLM-resourses#%E7%9F%A5%E8%AF%86%E5%BA%93-RAG)
- [智能体 Agents](https://github.com/WangRongsheng/awesome-LLM-resourses#%E6%99%BA%E8%83%BD%E4%BD%93-Agents)
- [搜索 Search](https://github.com/WangRongsheng/awesome-LLM-resourses#%E6%90%9C%E7%B4%A2-Search)
- [书籍 Book](https://github.com/WangRongsheng/awesome-LLM-resourses#%E4%B9%A6%E7%B1%8D-Book)
- [课程 Course](https://github.com/WangRongsheng/awesome-LLM-resourses#%E8%AF%BE%E7%A8%8B-Course)
- [教程 Tutorial](https://github.com/WangRongsheng/awesome-LLM-resourses#%E6%95%99%E7%A8%8B-Tutorial)
- [论文 Paper](https://github.com/WangRongsheng/awesome-LLM-resourses#%E8%AE%BA%E6%96%87-Paper)
- [Tips](https://github.com/WangRongsheng/awesome-LLM-resourses#tips)

## [Awesome-Domain-LLM](https://github.com/luban-agi/Awesome-Domain-LLM)

自以 ChatGPT 为代表的大语言模型出现以后，掀起了新一轮研究和应用浪潮，出现了许多包括 LLaMA、ChatGLM、Baichuan、Qwen 等在内的通用模型。随后，来自不同领域的从业人员在通用模型的基础上通过持续预训练/指令微调将其应用于垂直领域。

![](assets/images/cc496465737a6230293f36c764382b85_MD5.jpg)

本项目旨在收集和梳理垂直领域的**开源模型**、**数据集**及**评测基准**。欢迎大家贡献本项目未收录的开源模型、数据集、评测基准等内容，一起推动大模型赋能各行各业！

- [🤖 模型](https://github.com/luban-agi/Awesome-Domain-LLM#-%E6%A8%A1%E5%9E%8B)
  - [🌐 通用模型](https://github.com/luban-agi/Awesome-Domain-LLM#-%E9%80%9A%E7%94%A8%E6%A8%A1%E5%9E%8B)
  - [🧩 领域模型](https://github.com/luban-agi/Awesome-Domain-LLM#-%E9%A2%86%E5%9F%9F%E6%A8%A1%E5%9E%8B)
    - [🏥 医疗](https://github.com/luban-agi/Awesome-Domain-LLM#-%E5%8C%BB%E7%96%97)
    - [⚖ 法律](https://github.com/luban-agi/Awesome-Domain-LLM#-%E6%B3%95%E5%BE%8B)
    - [💰 金融](https://github.com/luban-agi/Awesome-Domain-LLM#-%E9%87%91%E8%9E%8D)
    - [🎓 教育](https://github.com/luban-agi/Awesome-Domain-LLM#-%E6%95%99%E8%82%B2)
    - [➕ 其他](https://github.com/luban-agi/Awesome-Domain-LLM#-%E5%85%B6%E4%BB%96)
- [📚 数据集](https://github.com/luban-agi/Awesome-Domain-LLM#-%E6%95%B0%E6%8D%AE%E9%9B%86)
- [📏 评测基准](https://github.com/luban-agi/Awesome-Domain-LLM#-%E8%AF%84%E6%B5%8B%E5%9F%BA%E5%87%86)
- [📎 附录](https://github.com/luban-agi/Awesome-Domain-LLM#-%E9%99%84%E5%BD%95)
  - [✨ 点赞历史](https://github.com/luban-agi/Awesome-Domain-LLM#-%E7%82%B9%E8%B5%9E%E5%8E%86%E5%8F%B2)
  - [🤝 友情链接](https://github.com/luban-agi/Awesome-Domain-LLM#-%E5%8F%8B%E6%83%85%E9%93%BE%E6%8E%A5)

## [awesome_LLMs_interview_notes](https://github.com/jackaduma/awesome_LLMs_interview_notes)

LLMs interview notes and answers

---

![](assets/images/c31953a1f1aba484caec36385ec18eb8_MD5.png)
