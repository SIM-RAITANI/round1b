# 🧠 Intelligent PDF Analyst – Connecting the Dots: Round 1B

This repository contains our solution for **Round 1B** of the _"Connecting the Dots"_ Challenge. Our system intelligently extracts, analyzes, and prioritizes relevant sections from a collection of PDF documents based on a **user-defined persona** and a specific **"job to be done" (JTBD)**.

Unlike simple keyword matchers, this solution understands the **semantic relevance** of document content using a combination of machine learning, structural parsing, and NLP techniques.

---

## 🎯 Goal

To build an offline, efficient, and intelligent document analysis pipeline that can:
- Parse PDF documents
- Classify and structure content into a hierarchical outline
- Understand semantic relevance to match text sections with a **persona** and a **job-to-be-done**
- Extract the most relevant information into a structured format

---

## 🛠️ Core Pipeline Components

### 1. 📄 Document Parsing & Feature Extraction
- **Tool:** [`PyMuPDF (fitz)`]
- Extracts:
  - Text blocks
  - Font sizes, boldness
  - Y-position (`pos_y`)
  - Word count and spacing
- **Libraries:** `pandas`, `numpy` for efficient data management and numerical operations

### 2. 🧩 Heading Classification using LightGBM
- **Model:** Pre-trained `LightGBM` classifier
- **Labels:** `'Title'`, `'H1'`, `'H2'`, `'H3'`, `'Body'`
- **Training Script:** `train_classifier.py`
- **Features Used:**
  - Visual layout features
  - Text embeddings
- **Persistence:** `joblib` is used for saving/loading the model

### 3. 🔍 Semantic Understanding with Fine-Tuned MiniLM
- **Model:** `MiniLM-L6-v2`, fine-tuned on **MS MARCO**
- **Libraries:** `transformers`, `sentence-transformers`, `torch`
- **Text Vectorization:**
  - 384-dimension embeddings
  - Applied to: Text blocks, persona descriptions, and JTBD queries
- **Similarity Measurement:** `cosine_similarity` from `scikit-learn`
- **Tokenization:** `nltk`'s `punkt` tokenizer ensures clean sentence-level processing

### 4. 🧱 Document Outline Construction & Section Extraction
- Rebuilds a structured **hierarchical outline** based on predicted labels
- Groups `'Body'` content under the nearest heading level
- Ranks and extracts relevant sections based on semantic similarity to the persona and JTBD

---

## 🧠 How the System Works

1. **Parse PDF** → Extract blocks + visual features
2. **Embed Text** → Use fine-tuned MiniLM for semantic vectorization
3. **Classify Blocks** → Use LightGBM to label each segment
4. **Build Outline** → Nest body content under appropriate headings
5. **Compute Relevance** → Match content to persona + JTBD
6. **Extract Relevant Sections** → Output most relevant structured segments

---

## ⚡ Performance Considerations

| Optimization        | Description |
|---------------------|-------------|
| **Offline Inference** | All models are loaded locally (no internet required) |
| **Lightweight Models** | MiniLM + LightGBM keep the memory and size under strict limits |
| **Batch Processing**   | Embedding and classification are done in efficient batches |
| **CPU-Optimized**      | Entire pipeline runs on CPU (no GPU needed) |
| **Memory Efficiency**  | Memory footprint stays well within 16GB RAM |

---

## 📦 Dependencies

Install the required Python packages:

```bash
pip install -r requirements.txt
