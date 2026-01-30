# 📊 RAPORT KOŃCOWY - PROJEKT TBO

## 👥 Zespół
- **Michał Fereniec** - (wpisz numer indeksu)
- Termin oddania: 29.01.2025
- Przedmiot: TBO (Testowanie Bezpieczeństwa Oprogramowania)

---

## 🎯 Realizacja Projektu

### ✅ ZADANIE 1 - Proces CI/CD (30/30 punktów)

#### 1.1 Zaprojektowanie procesu CI/CD

**Zaimplementowano:**
- ✅ GitHub Actions workflow (`.github/workflows/cicd-security.yml`)
- ✅ 7 jobów: unit-tests, sast-swiftlint, sast-semgrep, sca-dependencies, dast-security, build-app, security-summary
- ✅ Automatyczne uruchamianie przy push/PR do main, develop, feature/**, vulnerability-**
- ✅ Permissions: contents:read, security-events:write, actions:read

#### 1.2 Testy Bezpieczeństwa

**SAST (Static Application Security Testing):**
- ✅ **SwiftLint** - 4 custom security rules:
  - Hardcoded passwords (error)
  - Hardcoded API keys (error)
  - Insecure HTTP URLs (warning)
  - SQL Injection risk (error)
- ✅ **Semgrep** - 5 security patterns:
  - CWE-798: Hardcoded credentials
  - CWE-312: Cleartext storage
  - CWE-319: HTTP usage
  - Force unwrap detection
  - UserDefaults security check

**SCA (Software Composition Analysis):**
- ✅ Swift Package Manager dependency check
- ✅ Analiza Package.resolved
- ✅ Weryfikacja wersji frameworków

**DAST (Dynamic Application Security Testing):**
- ✅ Info.plist security check
- ✅ App Transport Security verification
- ✅ Runtime security configuration

**Testy Jednostkowe:**
- ✅ 5 testów XCTest
- ✅ Code coverage enabled
- ✅ Wszystkie testy przechodzą na main branch

#### 1.3 Build Strategy

| Branch | Config | Tag | Status |
|--------|--------|-----|--------|
| main | Release | :latest | ✅ Deployed |
| feature/** | Debug | :beta | 🧪 Testing |
| vulnerability-** | Debug | :test | ❌ Blocked |

#### 1.4 Mechanizm Blokowania

Pipeline FAIL-uje gdy:
- ❌ SwiftLint > 5 błędów (severity: error)
- ❌ Semgrep > 0 krytycznych podatności (ERROR)
- ❌ Testy jednostkowe nie przejdą
- ❌ Build się nie powiedzie

**Kod implementacji:**