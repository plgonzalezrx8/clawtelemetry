import re
from setuptools import setup, find_packages

with open("README.md", "r", encoding="utf-8") as f:
    long_description = f.read()

# Single source of truth: __version__ in dashboard.py
with open("dashboard.py", "r", encoding="utf-8") as f:
    version = re.search(r'__version__\s*=\s*"(.+?)"', f.read()).group(1)

setup(
    name="clawtelemetry",
    version=version,
    description="ClawTelemetry - Real-time observability dashboard for OpenClaw AI agents",
    long_description=long_description,
    long_description_content_type="text/markdown",
    author="ClawTelemetry Contributors",
    url="https://github.com/plgonzalezrx8/clawtelemetry",
    py_modules=["dashboard"],
    packages=find_packages(include=["clawtelemetry", "clawtelemetry.*"]),
    python_requires=">=3.8",
    install_requires=[
        "flask>=2.0",
        "waitress>=2.0",
        "cryptography>=3.0",
    ],
    extras_require={
        "otel": ["opentelemetry-proto>=1.20.0", "protobuf>=4.21.0"],
    },
    entry_points={
        "console_scripts": [
            "clawtelemetry=clawtelemetry.cli:main",
            # legacy: "clawtelemetry=dashboard:main",
        ],
    },
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
        "Programming Language :: Python :: 3.12",
        "Topic :: Software Development :: Quality Assurance",
        "Topic :: System :: Monitoring",
    ],
    keywords="clawtelemetry openclaw moltbot dashboard observability ai agent monitoring opentelemetry",
    license="MIT",
    project_urls={
        "Homepage": "https://github.com/plgonzalezrx8/clawtelemetry",
        "Bug Reports": "https://github.com/plgonzalezrx8/clawtelemetry/issues",
        "Source": "https://github.com/plgonzalezrx8/clawtelemetry",
    },
)
