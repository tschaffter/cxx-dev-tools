#pragma once

#include <algorithm>
#include <eventemitter/listener-base.hpp>
#include <eventemitter/listener.hpp>
#include <functional>
#include <list>
#include <map>
#include <memory>
#include <mutex>

namespace eventemitter {

template <class E>
class EventEmitter {
  public:
    EventEmitter();
    ~EventEmitter();

    template <typename... Args>
    unsigned int addListener(E eventId, std::function<void(Args...)> cb);
    unsigned int addListener(E eventId, std::function<void()> cb);

    template <typename LambdaType>
    unsigned int addListener(E eventId, LambdaType lambda) {
        return addListener(eventId, makeFunction(lambda));
    }

    template <typename... Args>
    unsigned int on(E eventId, std::function<void(Args...)> cb);
    unsigned int on(E eventId, std::function<void()> cb);

    template <typename LambdaType>
    unsigned int on(E eventId, LambdaType lambda) {
        return on(eventId, makeFunction(lambda));
    }

    void removeListener(unsigned int listenerId);
    void removeListeners();

    unsigned int numListeners();

    template <typename... Args>
    void emit(E eventId, Args... args);

  private:
    std::mutex _mutex;
    unsigned int _lastListenerId;
    std::multimap<E, std::shared_ptr<ListenerBase>> _listeners;

    EventEmitter(const EventEmitter &) = delete;
    const EventEmitter &operator=(const EventEmitter &) = delete;

    // http://stackoverflow.com/a/21000981
    template <typename T>
    struct functionTraits : public functionTraits<decltype(&T::operator())> {};

    template <typename ClassType, typename ReturnType, typename... Args>
    struct functionTraits<ReturnType (ClassType::*)(Args...) const> {
        typedef std::function<ReturnType(Args...)> f_type;
    };

    template <typename L>
    typename functionTraits<L>::f_type makeFunction(L l) {
        return (typename functionTraits<L>::f_type)(l);
    }
};

template <class E>
EventEmitter<E>::EventEmitter() : _lastListenerId(0) {}

template <class E>
EventEmitter<E>::~EventEmitter() {}

template <class E>
template <typename... Args>
unsigned int EventEmitter<E>::addListener(E eventId,
                                          std::function<void(Args...)> cb) {
    std::lock_guard<std::mutex> lock(_mutex);

    unsigned int listenerId = ++_lastListenerId;
    _listeners.insert(std::make_pair(
        eventId, std::make_shared<Listener<Args...>>(listenerId, cb)));

    return listenerId;
}

template <class E>
unsigned int EventEmitter<E>::addListener(E eventId, std::function<void()> cb) {
    // TODO: Is this function required?
    std::lock_guard<std::mutex> lock(_mutex);

    unsigned int listenerId = ++_lastListenerId;
    _listeners.insert(
        std::make_pair(eventId, std::make_shared<Listener<>>(listenerId, cb)));

    return listenerId;
}

template <class E>
unsigned int EventEmitter<E>::on(E eventId, std::function<void()> cb) {
    return addListener(eventId, cb);
}

template <class E>
template <typename... Args>
unsigned int EventEmitter<E>::on(E eventId, std::function<void(Args...)> cb) {
    return addListener(eventId, cb);
}

template <class E>
void EventEmitter<E>::removeListener(unsigned int listenerId) {
    std::lock_guard<std::mutex> lock(_mutex);

    auto i = std::find_if(
        _listeners.begin(), _listeners.end(),
        [&](std::pair<const unsigned int, std::shared_ptr<ListenerBase>> p) {
            return p.second->id == listenerId;
        });
    if (i != _listeners.end()) {
        _listeners.erase(i);
    } else {
        throw std::invalid_argument(
            "EventEmitter::removeListener: Invalid listener id");
    }
}

template <class E>
void EventEmitter<E>::removeListeners() {
    std::lock_guard<std::mutex> lock(_mutex);
    _listeners.clear();
}

template <class E>
unsigned int EventEmitter<E>::numListeners() {
    return _listeners.size();
}

template <class E>
template <typename... Args>
void EventEmitter<E>::emit(E eventId, Args... args) {
    std::list<std::shared_ptr<Listener<Args...>>> handlers;

    {
        std::lock_guard<std::mutex> lock(_mutex);

        auto range = _listeners.equal_range(eventId);
        handlers.resize(std::distance(range.first, range.second));
        std::transform(
            range.first, range.second, handlers.begin(),
            [](std::pair<const E, std::shared_ptr<ListenerBase>> p) {
                auto l = std::dynamic_pointer_cast<Listener<Args...>>(p.second);
                if (l) {
                    return l;
                } else {
                    throw std::logic_error(
                        "EventEmitter::emit: Invalid event signature");
                }
            });
    }

    for (auto &h : handlers) {
        h->cb(args...);
    }
}

}  // namespace eventemitter