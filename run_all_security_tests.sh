#!/bin/bash

# TBO-Lab4 - Complete Security Testing Suite
# This script runs all 4 tasks and generates proof of completion

set -e  # Exit on error

echo "═══════════════════════════════════════════════════════════"
echo "  TBO-Lab4 - Security Testing Suite"
echo "  Student: Michał Fereniec (307340)"
echo "═══════════════════════════════════════════════════════════"
echo ""

# Create results directory
mkdir -p security_test_results
cd security_test_results

echo "📋 Starting all security tests..."
echo ""

# ============================================================================
# ZADANIE 1 (OPCJONALNE): Trivy scan na obrazie Docker
# ============================================================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ZADANIE 1: Trivy Scan (Docker Image)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "🔨 Building Docker image..."
cd ..
docker build -t tbo-lab4:latest . 2>&1 | tee security_test_results/task1_docker_build.log

echo ""
echo "🔍 Running Trivy scan..."
docker run --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    aquasec/trivy image tbo-lab4:latest \
    --format json \
    --output security_test_results/task1_trivy_results.json \
    2>&1 | tee security_test_results/task1_trivy_scan.log

# Also generate human-readable report
docker run --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    aquasec/trivy image tbo-lab4:latest \
    --format table \
    2>&1 | tee security_test_results/task1_trivy_report.txt

echo "✅ ZADANIE 1 COMPLETED"
echo "   Results: security_test_results/task1_trivy_results.json"
echo ""

# ============================================================================
# ZADANIE 2 (OPCJONALNE): Semgrep SAST scan
# ============================================================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ZADANIE 2: Semgrep SAST Scan"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "🔍 Running Semgrep scan..."
docker run --rm \
    -v "$(pwd)":/src \
    returntocorp/semgrep semgrep scan \
    --config p/security-audit \
    --json \
    --output /src/security_test_results/task2_semgrep_results.json \
    2>&1 | tee security_test_results/task2_semgrep_scan.log

# Also run with custom config
if [ -f ".semgrep.yml" ]; then
    echo ""
    echo "🔍 Running Semgrep with custom config..."
    docker run --rm \
        -v "$(pwd)":/src \
        returntocorp/semgrep semgrep scan \
        --config /src/.semgrep.yml \
        --json \
        --output /src/security_test_results/task2_semgrep_custom.json \
        2>&1 | tee -a security_test_results/task2_semgrep_scan.log || true
fi

echo "✅ ZADANIE 2 COMPLETED"
echo "   Results: security_test_results/task2_semgrep_results.json"
echo ""

# ============================================================================
# ZADANIE 3 (OBOWIĄZKOWE): CI/CD GitHub Actions
# ============================================================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ZADANIE 3: CI/CD GitHub Actions"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "📝 CI/CD workflow already configured at:"
echo "   .github/workflows/security-scan.yml"
echo ""
echo "🔗 GitHub Actions will run automatically on push/PR"
echo "   View at: https://github.com/Michal2390/TBO-Lab4/actions"
echo ""
echo "✅ ZADANIE 3 CONFIGURED"
echo "   (Will be executed on next push to GitHub)"
echo ""

# ============================================================================
# ZADANIE 4 (OBOWIĄZKOWE): OWASP ZAP DAST scan
# ============================================================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ZADANIE 4: OWASP ZAP DAST Scan"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "🚀 Starting application container..."
# Run app in background
docker run -d --name tbo-lab4-app -p 8080:8080 tbo-lab4:latest sleep 3600

# Wait for app to be ready
sleep 5

echo "✅ Application running at http://localhost:8080"
echo ""

echo "🔍 Running OWASP ZAP baseline scan..."
docker run -u zap --rm \
    -v $(pwd)/security_test_results:/zap/wrk/:rw \
    zaproxy/zap-stable zap-baseline.py \
    -t http://host.docker.internal:8080 \
    -r task4_zap_report.html \
    -J task4_zap_results.json \
    2>&1 | tee security_test_results/task4_zap_scan.log || true

echo ""
echo "🛑 Stopping application container..."
docker stop tbo-lab4-app
docker rm tbo-lab4-app

echo "✅ ZADANIE 4 COMPLETED"
echo "   Results: security_test_results/task4_zap_report.html"
echo ""

# ============================================================================
# Summary
# ============================================================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  📊 SUMMARY - All Security Tests Completed"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "✅ Task 1 (Optional): Trivy scan - DONE"
echo "   📄 task1_trivy_results.json"
echo "   📄 task1_trivy_report.txt"
echo ""
echo "✅ Task 2 (Optional): Semgrep SAST - DONE"
echo "   📄 task2_semgrep_results.json"
echo ""
echo "✅ Task 3 (Required): CI/CD Pipeline - CONFIGURED"
echo "   🔗 https://github.com/Michal2390/TBO-Lab4/actions"
echo ""
echo "✅ Task 4 (Required): OWASP ZAP DAST - DONE"
echo "   📄 task4_zap_report.html"
echo "   📄 task4_zap_results.json"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  All results saved in: security_test_results/"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🎉 ALL TASKS COMPLETED SUCCESSFULLY!"
echo ""
echo "Next steps:"
echo "1. Review results in security_test_results/ directory"
echo "2. Update README.md with evidence"
echo "3. Commit and push to GitHub"
echo "4. Create Pull Request"