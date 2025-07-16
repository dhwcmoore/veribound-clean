import json
import sys
import os
from datetime import datetime
import matplotlib.pyplot as plt

def load_data(filename):
    with open(filename, "r") as f:
        return json.load(f)

def plot_results(data, out_base):
    results = data.get("flags", [])
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

def write_html_report(data, png_path, base_name):
    html_file = f"{base_name}.html"
    with open(html_file, "w") as f:
        f.write("""
<html>
<head>
  <title>VeriBound Report</title>
  <style>
    body { font-family: sans-serif; padding: 2em; background-color: #f9f9f9; color: #111; }
    h1 { color: #003366; }
    .status-green { color: green; font-weight: bold; }
    .status-yellow { color: goldenrod; font-weight: bold; }
    .status-red { color: red; font-weight: bold; }
    code { background: #eee; padding: 0.2em; border-radius: 3px; }
    img { max-width: 100%; border: 1px solid #ccc; margin-top: 1em; }
  </style>
</head>
<body>
""")

        f.write("<h1>🧠 VeriBound Verification Report</h1>\n")

        color = data.get("color", "UNKNOWN").lower()
        f.write(f"<p><strong>Status:</strong> <span class='status-{color}'>" + color.upper() + "</span></p>\n")


        seal = data.get("seal", "N/A")
        f.write(f"<p><strong>Seal Hash:</strong> <code>{seal}</code></p>\n")

        irrational = data.get("irrational_marker", "(not available)")
        f.write(f"<p><strong>🔢 Irrational Marker:</strong> <code>{irrational}</code></p>\n")

        if os.path.exists(png_path):
            f.write(f"<h2>📊 Verification Chart</h2>\n")
            f.write(f"<img src='{os.path.basename(png_path)}' alt='Verification Chart'>\n")


        flags = data.get("flags", [])
        if flags:
            f.write("<h2>⚠️ Flags</h2><ul>\n")
            for flag in flags:
                # If flag is a dict, render key info
                if isinstance(flag, dict):
                    cat = flag.get("category", "N/A")
                    verdict = flag.get("verdict", "N/A")
                    lower = flag.get("lower", "?")
                    upper = flag.get("upper", "?")
                    f.write(f"<li><strong>{cat}</strong>: {verdict} (range: {lower}–{upper})</li>\n")
                else:
                    f.write(f"<li>{flag}</li>\n")
            f.write("</ul>\n")
        else:
            f.write("<p>✅ No symbolic flags detected.</p>\n")

        f.write("</body></html>\n")
    print(f"📝 Dashboard saved as: {html_file}")
import os
import hashlib
import datetime
from pathlib import Path

# 1. Compute seal (based on input data)
seal = hashlib.sha256(json.dumps(data).encode()).hexdigest()

# 2. Generate optional irrational marker (enterprise-only)
salt = os.getenv("VERIBOUND_SALT")
irrational_number = None
salt_used = False

if salt:
    combined = (seal + salt).encode()
    irrational_seed = hashlib.sha256(combined).hexdigest()
    irrational_number = int(irrational_seed, 16) / 10**77
    salt_used = True

# 3. Placeholder for hardware trust anchors
hardware_id = "MAC-XYZ-123456"  # Reserved
hardware_entropy = None         # Reserved

# 4. Prepare result directory
Path("results").mkdir(exist_ok=True)
now = datetime.datetime.now(datetime.timezone.utc)
timestamp = now.strftime("%Y%m%d_%H%M%S")
output_file = f"results/veribound_output_{timestamp}.json"

# 5. Build result object
output_data = {
    "input": data,
    "template": template,
    "flags": [],  # ← Replace with your actual result variable
    "memory_overlay": {},  # ← Add your memory output if available
    "seal": seal,
    "irrational_marker": f"{irrational_number:.40f}" if salt_used else "(not generated)",
    "timestamp": now.isoformat(),
    "color": color,
    "verified_by": "VeriBound 0.1.3"
}

# 6. Save full result
with open(output_file, "w") as f:
    json.dump(output_data, f, indent=2)
print(f"🟢 Full verification result saved to {output_file}")

# 7. Save short summary
summary_log = {
    "file": file_path,
    "timestamp": now.isoformat(),
    "status": "PASS" if len(output_data["flags"]) == 0 else "FAIL",
    "color": color,
    "seal": seal,
    "template_used": template_path,
    "verified_by": "VeriBound 0.1.3"
}
with open("results/last_summary_log.json", "w") as f:
    json.dump(summary_log, f, indent=2)
print("📄 Summary log saved to results/last_summary_log.json")


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
