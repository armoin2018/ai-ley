---
applyTo: 'ionic, @ionic'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on Ionic 7+ with Angular/React/Vue and Capacitor'
---

# Ionic Framework Instructions for AI Agents

## When to Use Ionic

Use Ionic when you need:

- Cross-platform apps using web technologies (HTML, CSS, JavaScript)
- Leveraging existing web framework skills (Angular, React, Vue)
- Rapid prototyping with native-like UI components
- Progressive Web Apps (PWAs) with mobile deployment
- Cost-effective cross-platform development
- Apps that require web deployment alongside mobile
- Teams with strong web development experience

## When to Avoid Ionic

Consider alternatives when:

- Building performance-critical games or graphics-intensive apps
- Need deep native platform integrations (consider React Native/Flutter)
- Team lacks web development experience
- App requires complex native functionality
- Maximum native performance is essential
- Working with AR/VR or complex animations

## Framework Overview

- **Framework**: Ionic 7.x with Capacitor 5.x
- **Type**: Hybrid mobile app framework using web technologies
- **Architecture**: Web components with native bridge via Capacitor
- **Language**: JavaScript/TypeScript with Angular, React, or Vue
- **Use Cases**: Cross-platform mobile apps, PWAs, hybrid applications

## Installation & Setup

### ✅ Recommended: Ionic CLI with Framework of Choice

```bash
# Install Ionic CLI globally
npm install -g @ionic/cli

# Create new Ionic app with Angular (default)
ionic start myApp tabs --type=angular
ionic start myApp blank --type=angular

# Create with React
ionic start myApp tabs --type=react
ionic start myApp blank --type=react

# Create with Vue
ionic start myApp tabs --type=vue
ionic start myApp blank --type=vue

# Navigate and serve
cd myApp
ionic serve
```

### ✅ Capacitor Setup for Native Deployment

```bash
# Add native platforms
ionic capacitor add ios
ionic capacitor add android

# Build and sync
ionic build
ionic capacitor sync

# Open in native IDEs
ionic capacitor open ios
ionic capacitor open android

# Run on device
ionic capacitor run ios
ionic capacitor run android
```

### AI Agent Decision Tree

- **For Angular teams**: Use Ionic Angular for familiar patterns
- **For React teams**: Use Ionic React with React Router
- **For Vue teams**: Use Ionic Vue with Vue Router
- **For web-first**: Start with PWA, add native later
- **For native-first**: Use Capacitor from the beginning

## Project Structure

### ✅ Ionic Angular Project Structure

```
ionic-angular-app/
├── src/
│   ├── app/
│   │   ├── tabs/              # Tab navigation
│   │   │   ├── tabs.page.html
│   │   │   ├── tabs.page.ts
│   │   │   └── tabs-routing.module.ts
│   │   ├── tab1/              # Individual tabs
│   │   ├── tab2/
│   │   ├── tab3/
│   │   ├── services/          # Angular services
│   │   ├── guards/            # Route guards
│   │   ├── models/            # TypeScript interfaces
│   │   ├── components/        # Shared components
│   │   ├── app.component.ts   # Root component
│   │   ├── app.module.ts      # Root module
│   │   └── app-routing.module.ts
│   ├── assets/               # Static assets
│   ├── theme/                # CSS theming
│   ├── environments/         # Environment configs
│   └── index.html
├── android/                  # Android platform
├── ios/                      # iOS platform
├── capacitor.config.ts       # Capacitor configuration
├── ionic.config.json         # Ionic configuration
└── package.json
```

### ✅ Ionic React Project Structure

```
ionic-react-app/
├── src/
│   ├── pages/                # Page components
│   │   ├── Tab1.tsx
│   │   ├── Tab2.tsx
│   │   └── Tab3.tsx
│   ├── components/           # Reusable components
│   │   ├── ExploreContainer.tsx
│   │   └── UserCard.tsx
│   ├── hooks/                # Custom React hooks
│   ├── services/             # API and business logic
│   ├── models/               # TypeScript types
│   ├── contexts/             # React contexts
│   ├── App.tsx               # Root component
│   ├── App.test.tsx          # App tests
│   └── index.tsx             # Entry point
├── public/                   # Static assets
├── android/                  # Android platform
├── ios/                      # iOS platform
├── capacitor.config.ts       # Capacitor configuration
└── package.json
```

## Core Concepts

### Ionic Components with Angular

✅ **Best Practice**: Ionic UI components with Angular patterns

```typescript
// tab1/tab1.page.ts
import { Component, OnInit } from '@angular/core';
import { AlertController, ToastController, LoadingController } from '@ionic/angular';
import { UserService } from '../services/user.service';

interface User {
  id: string;
  name: string;
  email: string;
  avatar?: string;
}

@Component({
  selector: 'app-tab1',
  templateUrl: 'tab1.page.html',
  styleUrls: ['tab1.page.scss'],
})
export class Tab1Page implements OnInit {
  users: User[] = [];
  loading = false;
  searchTerm = '';

  constructor(
    private userService: UserService,
    private alertController: AlertController,
    private toastController: ToastController,
    private loadingController: LoadingController,
  ) {}

  ngOnInit() {
    this.loadUsers();
  }

  async loadUsers() {
    const loading = await this.loadingController.create({
      message: 'Loading users...',
    });
    await loading.present();

    try {
      this.users = await this.userService.getUsers();
    } catch (error) {
      await this.showError('Failed to load users');
    } finally {
      await loading.dismiss();
    }
  }

  async deleteUser(user: User) {
    const alert = await this.alertController.create({
      header: 'Confirm Delete',
      message: `Are you sure you want to delete ${user.name}?`,
      buttons: [
        {
          text: 'Cancel',
          role: 'cancel',
        },
        {
          text: 'Delete',
          role: 'destructive',
          handler: async () => {
            try {
              await this.userService.deleteUser(user.id);
              this.users = this.users.filter((u) => u.id !== user.id);
              await this.showToast('User deleted successfully');
            } catch (error) {
              await this.showError('Failed to delete user');
            }
          },
        },
      ],
    });
    await alert.present();
  }

  async showError(message: string) {
    const toast = await this.toastController.create({
      message,
      duration: 3000,
      color: 'danger',
      position: 'top',
    });
    await toast.present();
  }

  async showToast(message: string) {
    const toast = await this.toastController.create({
      message,
      duration: 2000,
      color: 'success',
      position: 'bottom',
    });
    await toast.present();
  }

  get filteredUsers() {
    if (!this.searchTerm) return this.users;
    return this.users.filter(
      (user) =>
        user.name.toLowerCase().includes(this.searchTerm.toLowerCase()) ||
        user.email.toLowerCase().includes(this.searchTerm.toLowerCase()),
    );
  }
}
```

```html
<!-- tab1/tab1.page.html -->
<ion-header [translucent]="true">
  <ion-toolbar>
    <ion-title>Users</ion-title>
    <ion-buttons slot="end">
      <ion-button (click)="loadUsers()">
        <ion-icon name="refresh"></ion-icon>
      </ion-button>
    </ion-buttons>
  </ion-toolbar>
</ion-header>

<ion-content [fullscreen]="true">
  <ion-header collapse="condense">
    <ion-toolbar>
      <ion-title size="large">Users</ion-title>
    </ion-toolbar>
  </ion-header>

  <ion-searchbar [(ngModel)]="searchTerm" placeholder="Search users..." debounce="300">
  </ion-searchbar>

  <ion-list>
    <ion-item *ngFor="let user of filteredUsers; trackBy: trackByUserId">
      <ion-avatar slot="start">
        <img [src]="user.avatar || 'assets/default-avatar.png'" [alt]="user.name" />
      </ion-avatar>

      <ion-label>
        <h2>{{ user.name }}</h2>
        <p>{{ user.email }}</p>
      </ion-label>

      <ion-button fill="clear" slot="end" (click)="deleteUser(user)">
        <ion-icon name="trash" color="danger"></ion-icon>
      </ion-button>
    </ion-item>
  </ion-list>

  <ion-infinite-scroll (ionInfinite)="loadMore($event)">
    <ion-infinite-scroll-content></ion-infinite-scroll-content>
  </ion-infinite-scroll>
</ion-content>
```

### Ionic Components with React

✅ **Best Practice**: Ionic React with hooks and TypeScript

```typescript
// pages/Tab1.tsx
import React, { useState, useEffect } from 'react';
import {
  IonContent,
  IonHeader,
  IonPage,
  IonTitle,
  IonToolbar,
  IonList,
  IonItem,
  IonLabel,
  IonAvatar,
  IonButton,
  IonIcon,
  IonSearchbar,
  IonRefresher,
  IonRefresherContent,
  IonLoading,
  useIonAlert,
  useIonToast,
} from '@ionic/react';
import { trash, refresh } from 'ionicons/icons';
import { useUsers } from '../hooks/useUsers';

interface User {
  id: string;
  name: string;
  email: string;
  avatar?: string;
}

const Tab1: React.FC = () => {
  const [searchTerm, setSearchTerm] = useState('');
  const { users, loading, error, fetchUsers, deleteUser } = useUsers();
  const [presentAlert] = useIonAlert();
  const [presentToast] = useIonToast();

  useEffect(() => {
    fetchUsers();
  }, [fetchUsers]);

  useEffect(() => {
    if (error) {
      presentToast({
        message: error,
        duration: 3000,
        color: 'danger',
        position: 'top',
      });
    }
  }, [error, presentToast]);

  const handleDeleteUser = (user: User) => {
    presentAlert({
      header: 'Confirm Delete',
      message: `Are you sure you want to delete ${user.name}?`,
      buttons: [
        'Cancel',
        {
          text: 'Delete',
          role: 'destructive',
          handler: async () => {
            try {
              await deleteUser(user.id);
              presentToast({
                message: 'User deleted successfully',
                duration: 2000,
                color: 'success',
                position: 'bottom',
              });
            } catch (err) {
              presentToast({
                message: 'Failed to delete user',
                duration: 3000,
                color: 'danger',
                position: 'top',
              });
            }
          },
        },
      ],
    });
  };

  const handleRefresh = async (event: CustomEvent) => {
    await fetchUsers();
    event.detail.complete();
  };

  const filteredUsers = users.filter(
    (user) =>
      user.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
      user.email.toLowerCase().includes(searchTerm.toLowerCase()),
  );

  return (
    <IonPage>
      <IonHeader translucent>
        <IonToolbar>
          <IonTitle>Users</IonTitle>
          <IonButton slot="end" fill="clear" onClick={() => fetchUsers()}>
            <IonIcon icon={refresh} />
          </IonButton>
        </IonToolbar>
      </IonHeader>

      <IonContent fullscreen>
        <IonHeader collapse="condense">
          <IonToolbar>
            <IonTitle size="large">Users</IonTitle>
          </IonToolbar>
        </IonHeader>

        <IonRefresher slot="fixed" onIonRefresh={handleRefresh}>
          <IonRefresherContent />
        </IonRefresher>

        <IonSearchbar
          value={searchTerm}
          onIonInput={(e) => setSearchTerm(e.detail.value!)}
          placeholder="Search users..."
          debounce={300}
        />

        <IonList>
          {filteredUsers.map((user) => (
            <IonItem key={user.id}>
              <IonAvatar slot="start">
                <img src={user.avatar || '/assets/default-avatar.png'} alt={user.name} />
              </IonAvatar>

              <IonLabel>
                <h2>{user.name}</h2>
                <p>{user.email}</p>
              </IonLabel>

              <IonButton fill="clear" slot="end" onClick={() => handleDeleteUser(user)}>
                <IonIcon icon={trash} color="danger" />
              </IonButton>
            </IonItem>
          ))}
        </IonList>

        <IonLoading isOpen={loading} message="Loading users..." />
      </IonContent>
    </IonPage>
  );
};

export default Tab1;
```

### Capacitor Native Integration

✅ **Best Practice**: Using Capacitor plugins for native functionality

```typescript
// services/camera.service.ts
import { Camera, CameraResultType, CameraSource } from '@capacitor/camera';
import { Filesystem, Directory } from '@capacitor/filesystem';
import { Preferences } from '@capacitor/preferences';

export class CameraService {
  async takePicture(): Promise<string | undefined> {
    try {
      const image = await Camera.getPhoto({
        quality: 90,
        allowEditing: false,
        resultType: CameraResultType.Uri,
        source: CameraSource.Camera,
      });

      if (image.webPath) {
        // Save to device storage
        const savedFile = await this.saveImageToDevice(image.webPath);
        return savedFile;
      }
    } catch (error) {
      console.error('Error taking picture:', error);
      throw new Error('Failed to take picture');
    }
  }

  async selectFromGallery(): Promise<string | undefined> {
    try {
      const image = await Camera.getPhoto({
        quality: 90,
        allowEditing: false,
        resultType: CameraResultType.Uri,
        source: CameraSource.Photos,
      });

      if (image.webPath) {
        const savedFile = await this.saveImageToDevice(image.webPath);
        return savedFile;
      }
    } catch (error) {
      console.error('Error selecting from gallery:', error);
      throw new Error('Failed to select image');
    }
  }

  private async saveImageToDevice(webPath: string): Promise<string> {
    try {
      // Convert web path to base64
      const response = await fetch(webPath);
      const blob = await response.blob();
      const base64Data = await this.convertBlobToBase64(blob);

      // Generate unique filename
      const fileName = `image_${Date.now()}.jpeg`;

      // Save to device filesystem
      await Filesystem.writeFile({
        path: fileName,
        data: base64Data,
        directory: Directory.Data,
      });

      // Save reference in preferences
      await this.saveImageReference(fileName);

      return fileName;
    } catch (error) {
      console.error('Error saving image:', error);
      throw new Error('Failed to save image');
    }
  }

  private convertBlobToBase64(blob: Blob): Promise<string> {
    return new Promise((resolve, reject) => {
      const reader = new FileReader();
      reader.onerror = reject;
      reader.onload = () => {
        resolve(reader.result as string);
      };
      reader.readAsDataURL(blob);
    });
  }

  private async saveImageReference(fileName: string) {
    const { value } = await Preferences.get({ key: 'saved_images' });
    const images = value ? JSON.parse(value) : [];
    images.push(fileName);
    await Preferences.set({
      key: 'saved_images',
      value: JSON.stringify(images),
    });
  }

  async getSavedImages(): Promise<string[]> {
    const { value } = await Preferences.get({ key: 'saved_images' });
    return value ? JSON.parse(value) : [];
  }

  async getImagePath(fileName: string): Promise<string> {
    try {
      const file = await Filesystem.readFile({
        path: fileName,
        directory: Directory.Data,
      });
      return `data:image/jpeg;base64,${file.data}`;
    } catch (error) {
      console.error('Error reading image:', error);
      throw new Error('Failed to read image');
    }
  }
}
```

### Navigation and Routing

✅ **Best Practice**: Ionic navigation with framework-specific routing

```typescript
// Angular routing (app-routing.module.ts)
import { NgModule } from '@angular/core';
import { PreloadAllModules, RouterModule, Routes } from '@angular/router';
import { AuthGuard } from './guards/auth.guard';

const routes: Routes = [
  {
    path: '',
    loadChildren: () => import('./tabs/tabs.module').then((m) => m.TabsPageModule),
    canActivate: [AuthGuard],
  },
  {
    path: 'login',
    loadChildren: () => import('./pages/login/login.module').then((m) => m.LoginPageModule),
  },
  {
    path: 'profile/:id',
    loadChildren: () => import('./pages/profile/profile.module').then((m) => m.ProfilePageModule),
    canActivate: [AuthGuard],
  },
  {
    path: '**',
    redirectTo: '/tabs/tab1',
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes, { preloadingStrategy: PreloadAllModules })],
  exports: [RouterModule],
})
export class AppRoutingModule {}
```

```typescript
// React routing (App.tsx)
import React from 'react';
import { Redirect, Route } from 'react-router-dom';
import {
  IonApp,
  IonIcon,
  IonLabel,
  IonRouterOutlet,
  IonTabBar,
  IonTabButton,
  IonTabs,
  setupIonicReact,
} from '@ionic/react';
import { IonReactRouter } from '@ionic/react-router';
import { ellipse, square, triangle } from 'ionicons/icons';
import Tab1 from './pages/Tab1';
import Tab2 from './pages/Tab2';
import Tab3 from './pages/Tab3';
import Login from './pages/Login';
import Profile from './pages/Profile';
import { AuthProvider, useAuth } from './contexts/AuthContext';

setupIonicReact();

const AppTabs: React.FC = () => {
  const { isAuthenticated } = useAuth();

  if (!isAuthenticated) {
    return <Redirect to="/login" />;
  }

  return (
    <IonTabs>
      <IonRouterOutlet>
        <Route exact path="/tabs/tab1" component={Tab1} />
        <Route exact path="/tabs/tab2" component={Tab2} />
        <Route path="/tabs/tab3" component={Tab3} />
        <Route path="/profile/:id" component={Profile} />
        <Route exact path="/tabs">
          <Redirect to="/tabs/tab1" />
        </Route>
      </IonRouterOutlet>

      <IonTabBar slot="bottom">
        <IonTabButton tab="tab1" href="/tabs/tab1">
          <IonIcon icon={triangle} />
          <IonLabel>Tab 1</IonLabel>
        </IonTabButton>
        <IonTabButton tab="tab2" href="/tabs/tab2">
          <IonIcon icon={ellipse} />
          <IonLabel>Tab 2</IonLabel>
        </IonTabButton>
        <IonTabButton tab="tab3" href="/tabs/tab3">
          <IonIcon icon={square} />
          <IonLabel>Tab 3</IonLabel>
        </IonTabButton>
      </IonTabBar>
    </IonTabs>
  );
};

const App: React.FC = () => (
  <IonApp>
    <AuthProvider>
      <IonReactRouter>
        <IonRouterOutlet>
          <Route path="/login" component={Login} exact />
          <Route path="/tabs" component={AppTabs} />
          <Route exact path="/">
            <Redirect to="/tabs" />
          </Route>
        </IonRouterOutlet>
      </IonReactRouter>
    </AuthProvider>
  </IonApp>
);

export default App;
```

## Best Practices

### ✅ Do's

- Use Ionic UI components for consistent native-like experience
- Implement proper navigation patterns with framework-specific routing
- Leverage Capacitor plugins for native device functionality
- Use TypeScript for better development experience and type safety
- Implement proper error handling and loading states
- Follow platform-specific design guidelines (iOS/Android)
- Use lazy loading for better performance
- Test on actual devices, not just browser/simulator

### ❌ Don'ts

- Don't mix Ionic components with other UI frameworks (Bootstrap, Material UI)
- Don't ignore platform-specific UI patterns and guidelines
- Don't forget to handle offline scenarios and network errors
- Don't use complex animations that may affect performance
- Don't ignore accessibility features and proper ARIA labels
- Don't skip testing on actual mobile devices
- Don't forget to optimize for different screen sizes and orientations
- Don't use deprecated Cordova plugins (use Capacitor instead)

### Performance Optimization

```typescript
// Virtual scrolling for large lists
import { Component } from '@angular/core';

@Component({
  selector: 'app-virtual-scroll',
  template: `
    <ion-content>
      <ion-virtual-scroll [items]="items" approxItemHeight="80px">
        <ion-item *virtualItem="let item; let itemBounds = bounds">
          <ion-avatar slot="start">
            <img [src]="item.avatar" />
          </ion-avatar>
          <ion-label>
            <h2>{{ item.name }}</h2>
            <p>{{ item.email }}</p>
          </ion-label>
        </ion-item>
      </ion-virtual-scroll>
    </ion-content>
  `,
})
export class VirtualScrollComponent {
  items = Array.from({ length: 10000 }, (_, i) => ({
    id: i,
    name: `User ${i}`,
    email: `user${i}@example.com`,
    avatar: `https://picsum.photos/64/64?random=${i}`,
  }));
}
```

```typescript
// Image optimization
import { Component } from '@angular/core';

@Component({
  selector: 'app-optimized-image',
  template: `
    <ion-img
      [src]="imageUrl"
      [alt]="altText"
      loading="lazy"
      (ionImgDidLoad)="onImageLoad()"
      (ionError)="onImageError()"
    >
    </ion-img>
  `,
})
export class OptimizedImageComponent {
  imageUrl = 'https://example.com/image.jpg';
  altText = 'Description';

  onImageLoad() {
    console.log('Image loaded successfully');
  }

  onImageError() {
    console.error('Failed to load image');
    // Set fallback image
    this.imageUrl = 'assets/fallback-image.jpg';
  }
}
```

## Development Workflow

### ✅ Recommended Development Setup

```bash
# Development
ionic serve                    # Web development
ionic serve --lab            # Device preview mode

# Build
ionic build                   # Web build
ionic build --prod           # Production build

# Native development
ionic capacitor build ios     # iOS build
ionic capacitor build android # Android build
ionic capacitor run ios --livereload    # Live reload on iOS
ionic capacitor run android --livereload # Live reload on Android

# Testing
npm test                      # Unit tests
npm run e2e                   # End-to-end tests

# Deployment
ionic build --prod
ionic capacitor sync
ionic capacitor build ios --prod
ionic capacitor build android --prod
```

### IDE Configuration

- **VS Code Extensions**: Ionic Extension Pack, Angular/React/Vue extensions
- **Settings**: Enable Ionic IntelliSense, TypeScript strict mode
- **Tools**: Ionic DevApp for testing, Chrome DevTools for debugging

### AI Agent Decision Matrix

| Scenario             | Recommended Approach          | Avoid                          |
| -------------------- | ----------------------------- | ------------------------------ |
| Web-first app        | Start with PWA, add native    | Native-first development       |
| Angular team         | Ionic Angular                 | Learning new framework         |
| React team           | Ionic React                   | Angular or Vue versions        |
| Vue team             | Ionic Vue                     | React or Angular versions      |
| Native functionality | Capacitor plugins             | Cordova plugins                |
| Performance critical | Consider React Native/Flutter | Heavy web frameworks           |
| Simple UI            | Ionic components              | Custom CSS frameworks          |
| Complex state        | Framework state management    | Ionic-specific state solutions |

## Integration Guidelines

- **With APIs**: Use framework-specific HTTP clients (HttpClient, Axios, fetch)
- **With databases**: Use SQLite via Capacitor or cloud solutions
- **With authentication**: Implement secure token storage with Capacitor Preferences
- **With push notifications**: Use Capacitor Push Notifications plugin
- **With analytics**: Integrate Firebase Analytics or similar
- **With social login**: Use Capacitor Community plugins

## Testing

### ✅ Component Testing (Angular)

```typescript
// tab1.page.spec.ts
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { IonicModule } from '@ionic/angular';
import { Tab1Page } from './tab1.page';
import { UserService } from '../services/user.service';

describe('Tab1Page', () => {
  let component: Tab1Page;
  let fixture: ComponentFixture<Tab1Page>;
  let userService: jasmine.SpyObj<UserService>;

  beforeEach(async () => {
    const userServiceSpy = jasmine.createSpyObj('UserService', ['getUsers', 'deleteUser']);

    await TestBed.configureTestingModule({
      declarations: [Tab1Page],
      imports: [IonicModule.forRoot()],
      providers: [{ provide: UserService, useValue: userServiceSpy }],
    }).compileComponents();

    fixture = TestBed.createComponent(Tab1Page);
    component = fixture.componentInstance;
    userService = TestBed.inject(UserService) as jasmine.SpyObj<UserService>;
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should load users on init', async () => {
    const mockUsers = [{ id: '1', name: 'John Doe', email: 'john@example.com' }];
    userService.getUsers.and.returnValue(Promise.resolve(mockUsers));

    await component.ngOnInit();

    expect(userService.getUsers).toHaveBeenCalled();
    expect(component.users).toEqual(mockUsers);
  });
});
```

### ✅ E2E Testing

```typescript
// e2e/src/app.e2e-spec.ts
import { AppPage } from './app.po';
import { browser, logging } from 'protractor';

describe('workspace-project App', () => {
  let page: AppPage;

  beforeEach(() => {
    page = new AppPage();
  });

  it('should display tab1 content', async () => {
    await page.navigateTo();
    expect(await page.getPageTitle()).toEqual('Users');
  });

  it('should navigate between tabs', async () => {
    await page.navigateTo();
    await page.clickTab2();
    expect(await page.getPageTitle()).toEqual('Tab 2');
  });

  afterEach(async () => {
    const logs = await browser.manage().logs().get(logging.Type.BROWSER);
    expect(logs).not.toContain(
      jasmine.objectContaining({
        level: logging.Level.SEVERE,
      } as logging.Entry),
    );
  });
});
```

## Security Considerations

- Store sensitive data securely using Capacitor Preferences with encryption
- Validate all user inputs and sanitize data before processing
- Use HTTPS for all API communications
- Implement proper authentication and session management
- Use Capacitor Security plugin for additional security features
- Enable CSP (Content Security Policy) for web deployments
- Obfuscate and minify code for production builds
- Implement certificate pinning for critical API calls

## Error Handling

```typescript
// services/error-handler.service.ts
import { Injectable } from '@angular/core';
import { ToastController, AlertController } from '@ionic/angular';

@Injectable({
  providedIn: 'root',
})
export class ErrorHandlerService {
  constructor(private toastController: ToastController, private alertController: AlertController) {}

  async handleError(error: any, context: string = 'Operation') {
    console.error(`Error in ${context}:`, error);

    let message = 'An unexpected error occurred';

    if (error?.message) {
      message = error.message;
    } else if (typeof error === 'string') {
      message = error;
    }

    const toast = await this.toastController.create({
      message: `${context} failed: ${message}`,
      duration: 3000,
      color: 'danger',
      position: 'top',
      buttons: [
        {
          text: 'Dismiss',
          role: 'cancel',
        },
      ],
    });

    await toast.present();
  }

  async showRetryAlert(message: string, retryCallback: () => Promise<void>) {
    const alert = await this.alertController.create({
      header: 'Error',
      message: message,
      buttons: [
        {
          text: 'Cancel',
          role: 'cancel',
        },
        {
          text: 'Retry',
          handler: async () => {
            try {
              await retryCallback();
            } catch (error) {
              await this.handleError(error, 'Retry');
            }
          },
        },
      ],
    });

    await alert.present();
  }
}
```

## AI Agent Quick Reference

- **Project Setup**: Use Ionic CLI with framework of choice (Angular/React/Vue)
- **Component Development**: Leverage Ionic UI components for native-like experience
- **Navigation**: Implement framework-specific routing patterns
- **Native Integration**: Use Capacitor plugins for device functionality
- **State Management**: Use framework-specific state management solutions
- **Performance**: Implement virtual scrolling, lazy loading, and image optimization
- **Testing**: Write unit tests with framework testing tools, E2E tests with Protractor/Cypress
- **Deployment**: Build for web and native platforms with appropriate optimizations

### [Pattern Name]

```[language]
// Example implementation
[code example]
```

### [Pattern Name]

```[language]
// Example implementation
[code example]
```

## Configuration

### [Config File 1]

```[format]
# Configuration options
[example configuration]
```

### [Config File 2]

```[format]
# Configuration options
[example configuration]
```

## Essential Commands

```bash
# Development
[dev server command]

# Testing
[test command]

# Building
[build command]

# Linting
[lint command]

# Package management
[install dependencies]
[add new package]
[update packages]
```

## Common Issues & Solutions

### [Issue 1]

**Problem**: [Description of the problem]
**Solution**: [How to solve it]

### [Issue 2]

**Problem**: [Description of the problem]
**Solution**: [How to solve it]

## Performance Optimization

- [Optimization technique 1]
- [Optimization technique 2]
- [Optimization technique 3]

## Security Considerations

- [Security best practice 1]
- [Security best practice 2]
- [Security best practice 3]

## Useful Resources

- **Official Documentation**: [URL]
- **Community Resources**: [URLs]
- **Learning Materials**: [URLs]
- **Tools & Extensions**: [List of helpful tools]

## Framework-Specific Guidelines

### Code Style

- Use TypeScript for type safety and better developer experience
- Follow Angular/React/Vue style guides for your chosen framework
- Use kebab-case for custom component selectors (`<my-component>`)
- Prefix Ionic pages with 'Page' suffix (`HomePage`, `ProfilePage`)
- Use PascalCase for component names and interfaces
- Use camelCase for methods, properties, and variables

### Architecture Patterns

- **MVVM Pattern**: Use with Angular's two-way data binding
- **Component-Based Architecture**: Modular, reusable UI components
- **State Management**: NgRx (Angular), Redux (React), Vuex/Pinia (Vue)
- **Service Layer**: Centralized business logic and API calls
- **Guard Pattern**: Route protection with authentication/authorization guards
- **Provider Pattern**: Dependency injection for services and utilities

## Integration Points

### Firebase Integration

- **Purpose**: Authentication, real-time database, cloud functions, analytics
- **Setup**: `npm install firebase @angular/fire` (for Angular)
- **Usage**: 
  ```typescript
  import { AngularFireAuth } from '@angular/fire/compat/auth';
  import { AngularFirestore } from '@angular/fire/compat/firestore';
  ```

### Native Plugin Integration

- **Purpose**: Access device features through Capacitor plugins
- **Setup**: `npm install @capacitor/[plugin-name]`
- **Usage**: Import and configure in platform-specific code
  ```typescript
  import { Camera } from '@capacitor/camera';
  import { Geolocation } from '@capacitor/geolocation';
  ```

## Version Compatibility

- **Node.js**: 16.x or later (18.x recommended)
- **Angular**: 16+ (for Ionic 7)
- **React**: 18+ (for Ionic React)
- **Vue**: 3+ (for Ionic Vue)
- **Capacitor**: 5.x
- **TypeScript**: 4.7+
- **Browser Support**: Modern browsers (Chrome 70+, Safari 13+, Firefox 63+)
- **iOS**: 13.0+ (via Capacitor)
- **Android**: API level 22+ (Android 5.1+)

## Troubleshooting

### Debug Mode

```bash
# Enable debug logging
ionic capacitor run ios --livereload --external
ionic capacitor run android --livereload --external

# Chrome DevTools for web debugging
ionic serve --lab

# Native debugging
ionic capacitor open ios  # Opens Xcode
ionic capacitor open android  # Opens Android Studio
```

### Log Analysis

- **Web**: Browser DevTools Console tab
- **iOS**: Xcode Console when running on device/simulator
- **Android**: Android Studio Logcat when running on device/emulator
- **Capacitor**: Check native logs for plugin-related issues

### Common Error Messages

- **Error**: `Cannot resolve dependency 'cordova-plugin-*'`
  **Cause**: Trying to use Cordova plugins instead of Capacitor
  **Solution**: Use equivalent Capacitor plugins or community plugins

- **Error**: `Module not found: Error: Can't resolve '@ionic/angular'`
  **Cause**: Ionic packages not installed or incorrect import path
  **Solution**: `npm install @ionic/angular` and verify import statements

- **Error**: `Platform 'ios' is not installed`
  **Cause**: iOS platform not added to Capacitor project
  **Solution**: `ionic capacitor add ios` then `ionic capacitor sync`

- **Error**: `Could not find valid entry point 'main'`
  **Cause**: Build output directory mismatch between framework and Capacitor
  **Solution**: Update `capacitor.config.ts` with correct `webDir` path
