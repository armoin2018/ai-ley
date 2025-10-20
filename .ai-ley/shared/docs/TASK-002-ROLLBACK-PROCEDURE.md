# TASK-002 Rollback Procedure

## Feature Flag: USE_TAB_STATE_HOOK

### Overview

The `USE_TAB_STATE_HOOK` feature flag controls whether the application uses the new `useTabState` hook for tab state management or falls back to the legacy localStorage approach. This document provides step-by-step instructions for rolling back to legacy behavior if issues are encountered.

## When to Rollback

Consider rolling back if you experience:

- **Data Loss**: Tab content disappearing after switching tabs
- **View Switching Bugs**: Unable to switch between visual and source views
- **Performance Issues**: Sluggish tab operations or frequent crashes
- **State Synchronization**: Tabs showing stale or incorrect content
- **Migration Issues**: Old content not loading correctly after upgrade

## Rollback Methods

### Method 1: Via Settings UI (Recommended)

1. **Open Settings**

   - Click the Settings icon (⚙️) in the top-right toolbar
   - Or press `Cmd/Ctrl + ,` keyboard shortcut

2. **Navigate to Feature Flags**

   - Click the **UML Flows** tab
   - Click the **Feature Flags** sub-tab (🚩 icon)

3. **Disable the Hook**

   - Locate "useTabState Hook" feature flag
   - Toggle the switch to **OFF** (left position)
   - The flag should show "⚠️ Rollback Mode Active"

4. **Reload the Application**

   - Close all open tabs or save your work
   - Refresh the page (`Cmd/Ctrl + R` or F5)
   - The application will now use legacy localStorage behavior

5. **Verify Rollback**
   - Open a workflow file
   - Switch between visual and source views
   - Verify content persists correctly
   - Check that all tabs function as expected

### Method 2: Via Browser Console (Emergency)

If the UI is inaccessible or broken:

1. **Open Browser DevTools**

   - Press `F12` or `Cmd/Ctrl + Shift + I`
   - Navigate to the **Console** tab

2. **Run Rollback Command**

   ```javascript
   // Disable the feature flag
   const settings = JSON.parse(localStorage.getItem('ai-ley-visual-editor-settings'));
   settings.umlFlows.featureFlags.useTabStateHook = false;
   settings.lastUpdated = new Date().toISOString();
   localStorage.setItem('ai-ley-visual-editor-settings', JSON.stringify(settings, null, 2));
   console.log('✅ Feature flag disabled. Please reload the page.');
   ```

3. **Reload the Page**

   - Press `Cmd/Ctrl + R` or F5
   - Or run: `window.location.reload()`

4. **Verify in Console**
   ```javascript
   // Check the flag status
   const settings = JSON.parse(localStorage.getItem('ai-ley-visual-editor-settings'));
   console.log('USE_TAB_STATE_HOOK:', settings.umlFlows.featureFlags.useTabStateHook);
   // Should output: false
   ```

### Method 3: Manual localStorage Edit (Advanced)

For persistent issues:

1. **Open Browser DevTools**

   - Press `F12` → **Application** tab → **Local Storage**
   - Select your domain in the left sidebar

2. **Locate Settings Key**

   - Find the key: `ai-ley-visual-editor-settings`
   - Double-click the value to edit

3. **Edit JSON Directly**

   - Locate the line: `"useTabStateHook": true`
   - Change it to: `"useTabStateHook": false`
   - Update `"lastUpdated"` to current timestamp
   - Press `Enter` to save

4. **Reload the Application**
   - Refresh the page
   - Verify changes took effect

## Legacy Behavior After Rollback

Once rolled back, the application will:

### Storage Keys Used

**Old (Legacy) Keys:**

```
puml-content-tab-plantuml-{tabId}  // New hook storage (read-only after rollback)
puml-content-{filePath}             // Primary legacy storage ✅
ai-ley-puml-files                   // File registry
```

### SourceEditor Behavior

- **Content Loading**: Reads from `puml-content-{filePath}` keys
- **Content Saving**: Writes to `puml-content-{filePath}` keys
- **Backward Compatibility**: Can still read from new hook keys if data exists
- **Migration**: Old content automatically accessible

### useWorkflowTabs Behavior

- **Tab Switching**: Uses legacy multi-key search pattern
- **Save Operations**: Writes directly to localStorage
- **File Management**: Manages file registry in `ai-ley-puml-files`

### Known Limitations (Legacy Mode)

1. **No Single Source of Truth**: State scattered across multiple localStorage keys
2. **Race Conditions**: Possible conflicts between components writing to same keys
3. **Duplicate State**: isSourceView state duplicated between parent and components
4. **No Centralized Migration**: Each component handles migration independently

## Re-Enabling the Feature

If you want to try the new hook again:

1. **Fix the Root Cause** (if known)

   - Check browser console for errors
   - Review recent changes in version control
   - Ensure you're on latest stable version

2. **Re-Enable via Settings**

   - Settings → UML Flows → Feature Flags
   - Toggle "useTabState Hook" to **ON**
   - Reload the page

3. **Test Thoroughly**
   - Create a new test workflow
   - Switch between views multiple times
   - Open/close multiple tabs
   - Verify content persists correctly

## Data Recovery

If you lost content during hook usage:

### Check New Hook Storage

```javascript
// Check if content exists in new hook keys
const tabId = 'your-tab-id'; // Get from tab component
const newKey = `puml-content-tab-plantuml-${tabId}`;
const content = localStorage.getItem(newKey);
console.log('Content in new storage:', content);
```

### Check Legacy Storage

```javascript
// Check legacy storage
const filePath = 'path/to/your/file.puml'; // From file path
const legacyKey = `puml-content-${filePath}`;
const content = localStorage.getItem(legacyKey);
console.log('Content in legacy storage:', content);
```

### Manual Recovery

1. **List All Keys**

   ```javascript
   // Find all content keys
   Object.keys(localStorage)
     .filter((key) => key.startsWith('puml-content'))
     .forEach((key) => {
       console.log(`${key}:`, localStorage.getItem(key)?.substring(0, 100));
     });
   ```

2. **Copy Content to Correct Key**
   ```javascript
   // If found in wrong key, copy to correct location
   const sourceKey = 'puml-content-tab-plantuml-123';
   const targetKey = 'puml-content-/path/to/file.puml';
   const content = localStorage.getItem(sourceKey);
   localStorage.setItem(targetKey, content);
   ```

## Reporting Issues

If you need to rollback, please report the issue:

1. **Gather Information**

   - What operation triggered the issue?
   - What error messages appeared (browser console)?
   - Can you reproduce the issue consistently?
   - Which browser/version are you using?

2. **Submit Report**

   - Create a GitHub issue with tag `task-002-regression`
   - Include browser console logs (errors and warnings)
   - Provide steps to reproduce
   - Note your rollback timestamp

3. **Include Context**
   ```javascript
   // Run this in console and include output
   const settings = JSON.parse(localStorage.getItem('ai-ley-visual-editor-settings'));
   console.log('Environment:', {
     featureFlags: settings.umlFlows.featureFlags,
     version: settings.version,
     browser: navigator.userAgent,
     localStorage: Object.keys(localStorage).filter((k) => k.includes('puml')).length + ' keys',
   });
   ```

## Troubleshooting

### Flag Doesn't Change

**Symptom**: Toggle appears to work but behavior doesn't change

**Solution**:

1. Check browser console for errors
2. Clear browser cache (`Cmd/Ctrl + Shift + Delete`)
3. Try Method 2 (Browser Console) instead
4. Verify settings save successfully (no exceptions thrown)

### Content Still Missing After Rollback

**Symptom**: Rolled back but content still not loading

**Solution**:

1. Run data recovery steps above
2. Check if content exists in any localStorage key
3. Manually copy from new keys to legacy keys
4. Export settings and reimport after clearing localStorage

### Page Won't Load After Rollback

**Symptom**: Application crashes or shows blank screen

**Solution**:

1. Open browser console and check for errors
2. Clear all localStorage: `localStorage.clear()`
3. Reload the page (will reset to defaults)
4. Restore your workflows from backup or exports

## Technical Details

### Flag Storage Location

```typescript
// In localStorage under key: 'ai-ley-visual-editor-settings'
{
  "umlFlows": {
    "featureFlags": {
      "useTabStateHook": true | false,  // The rollback flag
      "enableExperimentalFeatures": boolean
    }
  }
}
```

### Code Path Decision

```typescript
// In SourceEditor.tsx and similar components
import { isFeatureEnabled, FeatureFlag } from '@/utils/featureFlags';

if (isFeatureEnabled(FeatureFlag.USE_TAB_STATE_HOOK)) {
  // Use new hook (Phase 4-9 implementation)
  const tabState = useTabState(tabId, ...);
  tabState.updateSourceState(content);
} else {
  // Use legacy localStorage (pre-TASK-002 behavior)
  localStorage.setItem(`puml-content-${filePath}`, content);
}
```

### Migration Impact

- **Rollback is Safe**: Old localStorage keys are never deleted
- **Data Preserved**: Both storage mechanisms can coexist
- **Backward Compatible**: New hook can read old keys
- **Forward Compatible**: Old code ignores new keys

## Version History

- **Phase 6 (Current)**: Feature flag system implemented
- **Phases 1-5**: Hook developed, SourceEditor migrated
- **Phases 7-10 (Future)**: Full migration, testing

**Status**: BETA - Safe to rollback at any time

---

**Last Updated**: 2025-10-19 (TASK-002, Phase 6)
**Maintained By**: AI-LEY Development Team
**Related Documentation**:

- `TASK-002-INTEGRATION-PLAN.md`
- `TASK-002-PROGRESS.md`
- `TASK-002-PHASE5-AUDIT.md`
