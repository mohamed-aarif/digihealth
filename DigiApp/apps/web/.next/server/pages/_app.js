"use strict";
/*
 * ATTENTION: An "eval-source-map" devtool has been used.
 * This devtool is neither made for production nor for readable output files.
 * It uses "eval()" calls to create a separate source file with attached SourceMaps in the browser devtools.
 * If you are trying to read the output file, select a different devtool (https://webpack.js.org/configuration/devtool/)
 * or disable the default devtool with "devtool: false".
 * If you are looking for production-ready output files, see mode: "production" (https://webpack.js.org/configuration/mode/).
 */
(() => {
var exports = {};
exports.id = "pages/_app";
exports.ids = ["pages/_app"];
exports.modules = {

/***/ "./pages/_app.tsx":
/*!************************!*\
  !*** ./pages/_app.tsx ***!
  \************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   \"default\": () => (/* binding */ App)\n/* harmony export */ });\n/* harmony import */ var react_jsx_dev_runtime__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! react/jsx-dev-runtime */ \"react/jsx-dev-runtime\");\n/* harmony import */ var react_jsx_dev_runtime__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(react_jsx_dev_runtime__WEBPACK_IMPORTED_MODULE_0__);\n/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! react */ \"react\");\n/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(react__WEBPACK_IMPORTED_MODULE_1__);\n/* harmony import */ var _digihealth_core__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @digihealth/core */ \"../../packages/core/src/index.ts\");\n\n\n\nfunction App({ Component, pageProps }) {\n    return /*#__PURE__*/ (0,react_jsx_dev_runtime__WEBPACK_IMPORTED_MODULE_0__.jsxDEV)(_digihealth_core__WEBPACK_IMPORTED_MODULE_2__.AuthProvider, {\n        children: /*#__PURE__*/ (0,react_jsx_dev_runtime__WEBPACK_IMPORTED_MODULE_0__.jsxDEV)(Component, {\n            ...pageProps\n        }, void 0, false, {\n            fileName: \"/var/www/html/DigiApp/apps/web/pages/_app.tsx\",\n            lineNumber: 8,\n            columnNumber: 7\n        }, this)\n    }, void 0, false, {\n        fileName: \"/var/www/html/DigiApp/apps/web/pages/_app.tsx\",\n        lineNumber: 7,\n        columnNumber: 5\n    }, this);\n}\n//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiLi9wYWdlcy9fYXBwLnRzeCIsIm1hcHBpbmdzIjoiOzs7Ozs7Ozs7O0FBQTBCO0FBRXNCO0FBRWpDLFNBQVNFLElBQUksRUFBRUMsU0FBUyxFQUFFQyxTQUFTLEVBQVk7SUFDNUQscUJBQ0UsOERBQUNILDBEQUFZQTtrQkFDWCw0RUFBQ0U7WUFBVyxHQUFHQyxTQUFTOzs7Ozs7Ozs7OztBQUc5QiIsInNvdXJjZXMiOlsid2VicGFjazovL0BkaWdpaGVhbHRoL3dlYi8uL3BhZ2VzL19hcHAudHN4PzJmYmUiXSwic291cmNlc0NvbnRlbnQiOlsiaW1wb3J0IFJlYWN0IGZyb20gJ3JlYWN0JztcbmltcG9ydCB0eXBlIHsgQXBwUHJvcHMgfSBmcm9tICduZXh0L2FwcCc7XG5pbXBvcnQgeyBBdXRoUHJvdmlkZXIgfSBmcm9tICdAZGlnaWhlYWx0aC9jb3JlJztcblxuZXhwb3J0IGRlZmF1bHQgZnVuY3Rpb24gQXBwKHsgQ29tcG9uZW50LCBwYWdlUHJvcHMgfTogQXBwUHJvcHMpIHtcbiAgcmV0dXJuIChcbiAgICA8QXV0aFByb3ZpZGVyPlxuICAgICAgPENvbXBvbmVudCB7Li4ucGFnZVByb3BzfSAvPlxuICAgIDwvQXV0aFByb3ZpZGVyPlxuICApO1xufVxuIl0sIm5hbWVzIjpbIlJlYWN0IiwiQXV0aFByb3ZpZGVyIiwiQXBwIiwiQ29tcG9uZW50IiwicGFnZVByb3BzIl0sInNvdXJjZVJvb3QiOiIifQ==\n//# sourceURL=webpack-internal:///./pages/_app.tsx\n");

/***/ }),

/***/ "../../packages/core/src/auth.tsx":
/*!****************************************!*\
  !*** ../../packages/core/src/auth.tsx ***!
  \****************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   AuthProvider: () => (/* binding */ AuthProvider),\n/* harmony export */   useAuth: () => (/* binding */ useAuth)\n/* harmony export */ });\n/* harmony import */ var react_jsx_dev_runtime__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! react/jsx-dev-runtime */ \"react/jsx-dev-runtime\");\n/* harmony import */ var react_jsx_dev_runtime__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(react_jsx_dev_runtime__WEBPACK_IMPORTED_MODULE_0__);\n/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! react */ \"react\");\n/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(react__WEBPACK_IMPORTED_MODULE_1__);\n\n\nconst AuthContext = /*#__PURE__*/ (0,react__WEBPACK_IMPORTED_MODULE_1__.createContext)(undefined);\nconst AuthProvider = ({ children })=>{\n    const [user, setUser] = (0,react__WEBPACK_IMPORTED_MODULE_1__.useState)(null);\n    const [loading, setLoading] = (0,react__WEBPACK_IMPORTED_MODULE_1__.useState)(true);\n    (0,react__WEBPACK_IMPORTED_MODULE_1__.useEffect)(()=>{\n        const me = {\n            id: \"u1\",\n            name: \"Demo Patient\",\n            role: \"PATIENT\"\n        };\n        setUser(me);\n        setLoading(false);\n    }, []);\n    const signIn = async (token)=>{\n        const me = {\n            id: \"u1\",\n            name: \"Demo Patient\",\n            role: \"PATIENT\"\n        };\n        setUser(me);\n    };\n    const signOut = async ()=>{\n        setUser(null);\n    };\n    const setRoleForDemo = (role)=>{\n        setUser((u)=>u ? {\n                ...u,\n                role\n            } : {\n                id: \"demo\",\n                name: \"Demo\",\n                role\n            });\n    };\n    return /*#__PURE__*/ (0,react_jsx_dev_runtime__WEBPACK_IMPORTED_MODULE_0__.jsxDEV)(AuthContext.Provider, {\n        value: {\n            user,\n            role: user?.role ?? null,\n            loading,\n            signIn,\n            signOut,\n            setRoleForDemo\n        },\n        children: children\n    }, void 0, false, {\n        fileName: \"/var/www/html/DigiApp/packages/core/src/auth.tsx\",\n        lineNumber: 49,\n        columnNumber: 5\n    }, undefined);\n};\nconst useAuth = ()=>{\n    const ctx = (0,react__WEBPACK_IMPORTED_MODULE_1__.useContext)(AuthContext);\n    if (!ctx) throw new Error(\"useAuth must be used inside AuthProvider\");\n    return ctx;\n};\n//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiLi4vLi4vcGFja2FnZXMvY29yZS9zcmMvYXV0aC50c3giLCJtYXBwaW5ncyI6Ijs7Ozs7Ozs7OztBQUE4RTtBQW9COUUsTUFBTUssNEJBQWNKLG9EQUFhQSxDQUErQks7QUFFekQsTUFBTUMsZUFBd0QsQ0FBQyxFQUFFQyxRQUFRLEVBQUU7SUFDaEYsTUFBTSxDQUFDQyxNQUFNQyxRQUFRLEdBQUdOLCtDQUFRQSxDQUFrQjtJQUNsRCxNQUFNLENBQUNPLFNBQVNDLFdBQVcsR0FBR1IsK0NBQVFBLENBQUM7SUFFdkNELGdEQUFTQSxDQUFDO1FBQ1IsTUFBTVUsS0FBZTtZQUFFQyxJQUFJO1lBQU1DLE1BQU07WUFBZ0JDLE1BQU07UUFBVTtRQUN2RU4sUUFBUUc7UUFDUkQsV0FBVztJQUNiLEdBQUcsRUFBRTtJQUVMLE1BQU1LLFNBQVMsT0FBT0M7UUFDcEIsTUFBTUwsS0FBZTtZQUFFQyxJQUFJO1lBQU1DLE1BQU07WUFBZ0JDLE1BQU07UUFBVTtRQUN2RU4sUUFBUUc7SUFDVjtJQUVBLE1BQU1NLFVBQVU7UUFDZFQsUUFBUTtJQUNWO0lBRUEsTUFBTVUsaUJBQWlCLENBQUNKO1FBQ3RCTixRQUFRLENBQUNXLElBQ1BBLElBQUk7Z0JBQUUsR0FBR0EsQ0FBQztnQkFBRUw7WUFBSyxJQUFJO2dCQUFFRixJQUFJO2dCQUFRQyxNQUFNO2dCQUFRQztZQUFLO0lBRTFEO0lBRUEscUJBQ0UsOERBQUNYLFlBQVlpQixRQUFRO1FBQ25CQyxPQUFPO1lBQ0xkO1lBQ0FPLE1BQU1QLE1BQU1PLFFBQVE7WUFDcEJMO1lBQ0FNO1lBQ0FFO1lBQ0FDO1FBQ0Y7a0JBRUNaOzs7Ozs7QUFHUCxFQUFFO0FBRUssTUFBTWdCLFVBQVU7SUFDckIsTUFBTUMsTUFBTXZCLGlEQUFVQSxDQUFDRztJQUN2QixJQUFJLENBQUNvQixLQUFLLE1BQU0sSUFBSUMsTUFBTTtJQUMxQixPQUFPRDtBQUNULEVBQUUiLCJzb3VyY2VzIjpbIndlYnBhY2s6Ly9AZGlnaWhlYWx0aC93ZWIvLi4vLi4vcGFja2FnZXMvY29yZS9zcmMvYXV0aC50c3g/YTY1NCJdLCJzb3VyY2VzQ29udGVudCI6WyJpbXBvcnQgUmVhY3QsIHsgY3JlYXRlQ29udGV4dCwgdXNlQ29udGV4dCwgdXNlRWZmZWN0LCB1c2VTdGF0ZSB9IGZyb20gJ3JlYWN0JztcblxuZXhwb3J0IHR5cGUgVXNlclJvbGUgPSAnUEFUSUVOVCcgfCAnRE9DVE9SJyB8ICdGQU1JTFknO1xuXG5leHBvcnQgaW50ZXJmYWNlIEF1dGhVc2VyIHtcbiAgaWQ6IHN0cmluZztcbiAgbmFtZTogc3RyaW5nO1xuICBlbWFpbD86IHN0cmluZztcbiAgcm9sZTogVXNlclJvbGU7XG59XG5cbmludGVyZmFjZSBBdXRoQ29udGV4dFZhbHVlIHtcbiAgdXNlcjogQXV0aFVzZXIgfCBudWxsO1xuICByb2xlOiBVc2VyUm9sZSB8IG51bGw7XG4gIGxvYWRpbmc6IGJvb2xlYW47XG4gIHNpZ25JbjogKHRva2VuOiBzdHJpbmcpID0+IFByb21pc2U8dm9pZD47XG4gIHNpZ25PdXQ6ICgpID0+IFByb21pc2U8dm9pZD47XG4gIHNldFJvbGVGb3JEZW1vPzogKHJvbGU6IFVzZXJSb2xlKSA9PiB2b2lkO1xufVxuXG5jb25zdCBBdXRoQ29udGV4dCA9IGNyZWF0ZUNvbnRleHQ8QXV0aENvbnRleHRWYWx1ZSB8IHVuZGVmaW5lZD4odW5kZWZpbmVkKTtcblxuZXhwb3J0IGNvbnN0IEF1dGhQcm92aWRlcjogUmVhY3QuRkM8eyBjaGlsZHJlbjogUmVhY3QuUmVhY3ROb2RlIH0+ID0gKHsgY2hpbGRyZW4gfSkgPT4ge1xuICBjb25zdCBbdXNlciwgc2V0VXNlcl0gPSB1c2VTdGF0ZTxBdXRoVXNlciB8IG51bGw+KG51bGwpO1xuICBjb25zdCBbbG9hZGluZywgc2V0TG9hZGluZ10gPSB1c2VTdGF0ZSh0cnVlKTtcblxuICB1c2VFZmZlY3QoKCkgPT4ge1xuICAgIGNvbnN0IG1lOiBBdXRoVXNlciA9IHsgaWQ6ICd1MScsIG5hbWU6ICdEZW1vIFBhdGllbnQnLCByb2xlOiAnUEFUSUVOVCcgfTtcbiAgICBzZXRVc2VyKG1lKTtcbiAgICBzZXRMb2FkaW5nKGZhbHNlKTtcbiAgfSwgW10pO1xuXG4gIGNvbnN0IHNpZ25JbiA9IGFzeW5jICh0b2tlbjogc3RyaW5nKSA9PiB7XG4gICAgY29uc3QgbWU6IEF1dGhVc2VyID0geyBpZDogJ3UxJywgbmFtZTogJ0RlbW8gUGF0aWVudCcsIHJvbGU6ICdQQVRJRU5UJyB9O1xuICAgIHNldFVzZXIobWUpO1xuICB9O1xuXG4gIGNvbnN0IHNpZ25PdXQgPSBhc3luYyAoKSA9PiB7XG4gICAgc2V0VXNlcihudWxsKTtcbiAgfTtcblxuICBjb25zdCBzZXRSb2xlRm9yRGVtbyA9IChyb2xlOiBVc2VyUm9sZSkgPT4ge1xuICAgIHNldFVzZXIoKHU6IEF1dGhVc2VyIHwgbnVsbCkgPT5cbiAgICAgIHUgPyB7IC4uLnUsIHJvbGUgfSA6IHsgaWQ6ICdkZW1vJywgbmFtZTogJ0RlbW8nLCByb2xlIH0sXG4gICAgKTtcbiAgfTtcblxuICByZXR1cm4gKFxuICAgIDxBdXRoQ29udGV4dC5Qcm92aWRlclxuICAgICAgdmFsdWU9e3tcbiAgICAgICAgdXNlcixcbiAgICAgICAgcm9sZTogdXNlcj8ucm9sZSA/PyBudWxsLFxuICAgICAgICBsb2FkaW5nLFxuICAgICAgICBzaWduSW4sXG4gICAgICAgIHNpZ25PdXQsXG4gICAgICAgIHNldFJvbGVGb3JEZW1vLFxuICAgICAgfX1cbiAgICA+XG4gICAgICB7Y2hpbGRyZW59XG4gICAgPC9BdXRoQ29udGV4dC5Qcm92aWRlcj5cbiAgKTtcbn07XG5cbmV4cG9ydCBjb25zdCB1c2VBdXRoID0gKCkgPT4ge1xuICBjb25zdCBjdHggPSB1c2VDb250ZXh0KEF1dGhDb250ZXh0KTtcbiAgaWYgKCFjdHgpIHRocm93IG5ldyBFcnJvcigndXNlQXV0aCBtdXN0IGJlIHVzZWQgaW5zaWRlIEF1dGhQcm92aWRlcicpO1xuICByZXR1cm4gY3R4O1xufTsiXSwibmFtZXMiOlsiUmVhY3QiLCJjcmVhdGVDb250ZXh0IiwidXNlQ29udGV4dCIsInVzZUVmZmVjdCIsInVzZVN0YXRlIiwiQXV0aENvbnRleHQiLCJ1bmRlZmluZWQiLCJBdXRoUHJvdmlkZXIiLCJjaGlsZHJlbiIsInVzZXIiLCJzZXRVc2VyIiwibG9hZGluZyIsInNldExvYWRpbmciLCJtZSIsImlkIiwibmFtZSIsInJvbGUiLCJzaWduSW4iLCJ0b2tlbiIsInNpZ25PdXQiLCJzZXRSb2xlRm9yRGVtbyIsInUiLCJQcm92aWRlciIsInZhbHVlIiwidXNlQXV0aCIsImN0eCIsIkVycm9yIl0sInNvdXJjZVJvb3QiOiIifQ==\n//# sourceURL=webpack-internal:///../../packages/core/src/auth.tsx\n");

/***/ }),

/***/ "../../packages/core/src/index.ts":
/*!****************************************!*\
  !*** ../../packages/core/src/index.ts ***!
  \****************************************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _auth__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./auth */ \"../../packages/core/src/auth.tsx\");\n/* harmony reexport (unknown) */ var __WEBPACK_REEXPORT_OBJECT__ = {};\n/* harmony reexport (unknown) */ for(const __WEBPACK_IMPORT_KEY__ in _auth__WEBPACK_IMPORTED_MODULE_0__) if(__WEBPACK_IMPORT_KEY__ !== \"default\") __WEBPACK_REEXPORT_OBJECT__[__WEBPACK_IMPORT_KEY__] = () => _auth__WEBPACK_IMPORTED_MODULE_0__[__WEBPACK_IMPORT_KEY__]\n/* harmony reexport (unknown) */ __webpack_require__.d(__webpack_exports__, __WEBPACK_REEXPORT_OBJECT__);\n\n//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiLi4vLi4vcGFja2FnZXMvY29yZS9zcmMvaW5kZXgudHMiLCJtYXBwaW5ncyI6Ijs7Ozs7QUFBdUIiLCJzb3VyY2VzIjpbIndlYnBhY2s6Ly9AZGlnaWhlYWx0aC93ZWIvLi4vLi4vcGFja2FnZXMvY29yZS9zcmMvaW5kZXgudHM/M2I5NyJdLCJzb3VyY2VzQ29udGVudCI6WyJleHBvcnQgKiBmcm9tICcuL2F1dGgnO1xuIl0sIm5hbWVzIjpbXSwic291cmNlUm9vdCI6IiJ9\n//# sourceURL=webpack-internal:///../../packages/core/src/index.ts\n");

/***/ }),

/***/ "react":
/*!************************!*\
  !*** external "react" ***!
  \************************/
/***/ ((module) => {

module.exports = require("react");

/***/ }),

/***/ "react/jsx-dev-runtime":
/*!****************************************!*\
  !*** external "react/jsx-dev-runtime" ***!
  \****************************************/
/***/ ((module) => {

module.exports = require("react/jsx-dev-runtime");

/***/ })

};
;

// load runtime
var __webpack_require__ = require("../webpack-runtime.js");
__webpack_require__.C(exports);
var __webpack_exec__ = (moduleId) => (__webpack_require__(__webpack_require__.s = moduleId))
var __webpack_exports__ = (__webpack_exec__("./pages/_app.tsx"));
module.exports = __webpack_exports__;

})();