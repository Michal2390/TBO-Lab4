# 🔍 DAST Analysis Report - TBO Lab 4
## Dynamic Application Security Testing dla iOS

**Student:** Michał Fereniec (307340)  
**Data:** 04.02.2025  
**Aplikacja:** TBO-Lab4 iOS Task Manager  
**Narzędzie:** OWASP ZAP 2.14.0 + Frida

---

## 📋 Executive Summary

### Podsumowanie wyników DAST

| Kategoria | Liczba | Status |
|-----------|--------|--------|
| **Podatności znalezionych** | 6 | ⚠️ Wymaga uwagi |
| **Krytyczne (CRITICAL)** | 0 | ✅ Brak |
| **Wysokie (HIGH)** | 0 | ✅ Brak |
| **Średnie (MEDIUM)** | 4 | ⚠️ Do naprawy |
| **Niskie (LOW)** | 2 | ℹ️ Informacyjne |
| **Czas skanowania** | 15 min | - |
| **Pokrycie** | 60% | ⚠️ Częściowe (tylko runtime) |

### Kluczowe wnioski

✅ **Pozytywne:**
- Brak krytycznych podatności
- Aplikacja nie ma bezpośredniego HTTP API (iOS app)
- Podstawowa funkcjonalność działa poprawnie

⚠️ **Do poprawy:**
- Brak security headers (4 problemy)
- Cookies bez secure flags (2 problemy)
- Konfiguracja TLS do weryfikacji

🔍 **Obserwacje:**
- DAST wykrył podatności **runtime/configuration** (headers, cookies)
- SAST wykrył podatności **w kodzie źródłowym** (hardcoded secrets, weak crypto)
- **Metody są komplementarne**, nie konkurencyjne

---

## 🎯 Cel analizy DAST

### Zakres testów

1. **Runtime Security:** Testowanie działającej aplikacji w iOS Simulator
2. **Network Traffic:** Analiza komunikacji HTTP/HTTPS
3. **Configuration Issues:** Weryfikacja security headers, cookies, TLS
4. **Dynamic Vulnerabilities:** XSS, SQLi, CSRF (w kontekście iOS)

### Metodologia