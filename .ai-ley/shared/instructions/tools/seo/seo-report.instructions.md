
# 🧠 SEO Analysis AI Agent Instruction Set

## 📘 Purpose
To guide an AI agent system in performing an in-depth, multi-dimensional SEO analysis of a specified website.

## 🧩 Inputs
| Key               | Type   | Required | Description |
|------------------|--------|----------|-------------|
| website_url      | string | ✅       | URL of the website to be analyzed |
| focus_keywords   | array  | ❌       | List of keywords to evaluate SEO against |
| competitor_urls  | array  | ❌       | URLs of competitor websites for comparison |
| output_format    | enum   | ❌       | markdown | html | json | csv (default: markdown) |
| analysis_depth   | enum   | ❌       | standard | deep-dive (default: deep-dive) |

## 🧱 Workflow Steps
1. Crawl the Site
2. Extract Page Elements
3. Conduct Technical SEO Analysis
4. Perform On-Page Content Analysis
5. Evaluate UX & Performance Metrics
6. Check Backlinks and Off-Page SEO
7. Analyze Competitors
8. Synthesize and Prioritize Recommendations
9. Output Final Report

## 🔍 Details per Step
Each step is outlined in the accompanying HTML and PDF files with charts and visuals.

## 📊 Output Sample (JSON)
```json
{
  "summary": "...",
  "technical": { "issues": [ ... ] },
  "content": { "recommendations": [ ... ] },
  "performance": { "metrics": [ ... ] },
  "backlinks": { "insights": [ ... ] },
  "competitors": { "comparison": [ ... ] }
}
```
