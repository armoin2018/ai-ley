class EventManager {
  constructor(web3) {
    this.web3 = web3;
    this.subscriptions = new Map();
  }

  subscribe(eventName, contract, options, callback) {
    const subscription = contract.events[eventName](options, callback);
    this.subscriptions.set(eventName, subscription);
    return subscription;
  }

  unsubscribe(eventName) {
    const subscription = this.subscriptions.get(eventName);
    if (subscription) {
      subscription.unsubscribe();
      this.subscriptions.delete(eventName);
    }
  }

  unsubscribeAll() {
    this.subscriptions.forEach((subscription) => {
      subscription.unsubscribe();
    });
    this.subscriptions.clear();
  }
}