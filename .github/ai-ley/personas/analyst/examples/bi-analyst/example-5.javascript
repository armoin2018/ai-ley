// Tableau JavaScript API for embedded dashboards
class TableauDashboard {
    constructor(containerId, dashboardUrl, options = {}) {
        this.containerDiv = document.getElementById(containerId);
        this.url = dashboardUrl;
        this.viz = null;
        this.options = {
            width: '100%',
            height: '600px',
            hideTabs: true,
            hideToolbar: false,
            onFirstInteractive: this.onFirstInteractive.bind(this),
            ...options
        };
    }

    initialize() {
        this.viz = new tableau.Viz(this.containerDiv, this.url, this.options);
    }

    onFirstInteractive() {
        console.log('Dashboard loaded successfully');
        this.addFilterChangeListener();
    }

    addFilterChangeListener() {
        this.viz.addEventListener(tableau.TableauEventName.FILTER_CHANGE, (event) => {
            console.log('Filter changed:', event.getFilterAsync());
            this.updateExternalComponents(event);
        });
    }

    async applyFilter(worksheetName, fieldName, values) {
        const worksheet = this.viz.getWorkbook().getActiveSheet().getWorksheets().get(worksheetName);
        return await worksheet.applyFilterAsync(fieldName, values, tableau.FilterUpdateType.REPLACE);
    }

    async exportToPDF(options = {}) {
        const defaultOptions = {
            paperSizeOption: tableau.PaperSizeOption.A4,
            orientationOption: tableau.OrientationOption.PORTRAIT
        };
        return await this.viz.showExportPDFDialog({...defaultOptions, ...options});
    }

    updateExternalComponents(event) {
        // Update other dashboard components based on filter changes
        const filterInfo = event.getFilterAsync().then(filter => {
            document.dispatchEvent(new CustomEvent('dashboardFilterChange', {
                detail: { filter: filter }
            }));
        });
    }
}

// Usage
const dashboard = new TableauDashboard('dashboardContainer', 
    'https://public.tableau.com/views/SampleWorkbook/Dashboard1', {
    height: '800px',
    hideTabs: false,
    device: 'desktop'
});

dashboard.initialize();