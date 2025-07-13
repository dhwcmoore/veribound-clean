import json
import sys
import os
from datetime import datetime
import matplotlib.pyplot as plt

def load_data(filename):
    with open(filename, "r") as f:
        return json.load(f)

def plot_results(data, out_base):
    results = data["results"]
    categories = [r["category"] for r in results]
    verdicts = [r["verdict"] for r in results]

    verdict_colors = {"COMPLIANT": "green", "SAFE": "blue", "UNSAFE": "red", "WARNING": "orange"}
    colors = [verdict_colors.get(v, "gray") for v in verdicts]

    fig, ax = plt.subplots(figsize=(8, 3))
    ax.barh(categories, [r["upper"] - r["lower"] for r in results], left=[r["lower"] for r in results], color=colors)
    ax.set_xlabel("Range")
    ax.set_title("VeriBound Audit Ranges")
    plt.tight_layout()

    png_file = f"{out_base}.png"
    plt.savefig(png_file)
    print(f"📷 Chart saved as: {png_file}")

    return png_file

def write_html_report(data, png_path, out_base):
    html_file = f"{out_base}.html"
    with open(html_file, "w") as f:
        f.write("<html><head><title>VeriBound Report</title></head><body>\n")
        f.write("<h1>VeriBound Audit Report</h1>\n")
        f.write(f"<p><strong>Seal Hash:</strong> {data['seal_hash']}</p>\n")
        f.write(f"<p><strong>Irrational Signature:</strong> {data['irrational_signature']}</p>\n")
        f.write("<h2>Audit Results</h2>\n")
        f.write("<table border='1' cellpadding='5'>\n<tr><th>Category</th><th>Lower</th><th>Upper</th><th>Verdict</th></tr>\n")
        for r in data["results"]:
            f.write(f"<tr><td>{r['category']}</td><td>{r['lower']:.4f}</td><td>{r['upper']:.4f}</td><td>{r['verdict']}</td></tr>\n")
        f.write("</table>\n")
        f.write(f"<h2>Audit Chart</h2>\n<img src='{os.path.basename(png_path)}' width='600'>\n")
        f.write("</body></html>\n")
    print(f"📝 HTML report written to: {html_file}")

def main():
    if len(sys.argv) != 2:
        print("Usage: python3 generate_dashboard.py path/to/output.json")
        sys.exit(1)

    filename = sys.argv[1]
    data = load_data(filename)
    base_name = os.path.splitext(filename)[0]

    png_path = plot_results(data, base_name)
    write_html_report(data, png_path, base_name)

if __name__ == "__main__":
    main()
