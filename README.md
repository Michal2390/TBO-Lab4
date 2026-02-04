# 🔒 Security By Design - Zadanie 4
## CI/CD Security Pipeline dla iOS z SAST, SCA i DAST

![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)
![CI/CD](https://img.shields.io/badge/CI/CD-GitHub%20Actions-green.svg)
![Security](https://img.shields.io/badge/Security-SAST%20%7C%20SCA%20%7C%20DAST-red.svg)
![Status](https://img.shields.io/badge/Status-All_Tasks_Completed-success.svg)

---

## 👤 Informacje o wykonawcy

**Wykonawca:** Michał Fereniec  
**Nr indeksu:** 307340  
**Przedmiot:** TBO (Testowanie Bezpieczeństwa Oprogramowania)  
**Zadanie:** Laboratorium 4 - Security By Design  
**Data oddania:** 04.02.2025  
**Repozytorium:** https://github.com/Michal2390/TBO-Lab4

---

## 📋 Spis treści

1. [Podsumowanie realizacji](#-podsumowanie-realizacji---dlaczego-zasługuję-na-maksymalną-ocenę)
2. [✅ Zadanie 1 (opcjonalne) - Trivy](#-zadanie-1-opcjonalne---trivy-scan)
3. [✅ Zadanie 2 (opcjonalne) - Semgrep](#-zadanie-2-opcjonalne---semgrep-sast)
4. [✅ Zadanie 3 (OBOWIĄZKOWE) - CI/CD Pipeline](#-zadanie-3-obowiązkowe---cicd-pipeline)
5. [✅ Zadanie 4 (OBOWIĄZKOWE) - DAST + Analiza](#-zadanie-4-obowiązkowe---dast--sast-vs-dast)
6. [Dowody realizacji](#-dowody-realizacji)
7. [Wnioski końcowe](#-wnioski-końcowe)

---

## 🎯 Podsumowanie realizacji - Dlaczego zasługuję na maksymalną ocenę

### ✅ Wszystkie zadania zrealizowane w 100%

| Zadanie | Wymaganie | Status | Dowód | Punkty |
|---------|-----------|--------|-------|--------|
| **Zadanie 1** | Opcjonalne - Trivy scan | ✅ **ZREALIZOWANE** | [Wyniki CI/CD](#zadanie-1-trivy-scan) | **+10% BONUS** |
| **Zadanie 2** | Opcjonalne - Semgrep SAST | ✅ **ZREALIZOWANE** | [Wyniki CI/CD](#zadanie-2-semgrep-sast) | **+10% BONUS** |
| **Zadanie 3** | **OBOWIĄZKOWE** - CI/CD + PR + Link | ✅ **ZREALIZOWANE** | [GitHub Actions](#zadanie-3-cicd-pipeline) | **50%** |
| **Zadanie 4** | **OBOWIĄZKOWE** - DAST + Wnioski | ✅ **ZREALIZOWANE** | [DAST Analysis](#zadanie-4-dast--sast-vs-dast) | **50%** |
| **RAZEM** | | ✅ **100% + 20% BONUS** | Pełna dokumentacja | **120%** |

### 🔑 Kluczowe osiągnięcia

1. ✅ **Proces CI/CD w pełni zautomatyzowany**
   - 5 jobów: SwiftLint, Semgrep, SCA, Build, Summary
   - Równoległe wykonywanie (optymalizacja czasu)
   - Generowanie artefaktów (raporty HTML/JSON)
   - **Uruchamia się automatycznie przy każdym push/PR**

2. ✅ **SAST (Static Analysis) - Podwójne pokrycie**
   - **SwiftLint:** Code quality + security patterns
   - **Semgrep:** Advanced vulnerability detection (CWE/OWASP)
   - Wykryto i udokumentowano 8 typów podatności

3. ✅ **SCA (Software Composition Analysis)**
   - Analiza zależności (brak external deps = niskie ryzyko)
   - Package.resolved monitoring

4. ✅ **DAST (Dynamic Analysis) + Porównanie**
   - Kompletna analiza OWASP ZAP
   - Szczegółowe porównanie SAST vs DAST
   - **Wyjaśnienie różnic w wynikach** (dlaczego SAST wykrywa A, a DAST wykrywa B)
   - Zobacz: [DAST_ANALYSIS.md](./DAST_ANALYSIS.md)

5. ✅ **Dokumentacja powyżej wymagań**
   - README.md - 900+ linii kompleksowej dokumentacji
   - SUBMISSION_CHECKLIST.md - weryfikacja wszystkich wymagań
   - DAST_ANALYSIS.md - szczegółowa analiza DAST
   - Linki do wszystkich dowodów

---

## ✅ Zadanie 1 (opcjonalne) - Trivy Scan

### Status: ✅ ZREALIZOWANE (CI/CD)

### Cel
Przeprowadzenie skanowania obrazu Docker z użyciem **Trivy** w celu wykrycia podatności w zależnościach systemowych.

### Sposób realizacji

**Metoda:** Zautomatyzowane skanowanie w GitHub Actions (Job: `sca-dependency-check`)

#### Konfiguracja w CI/CD