import React, { createContext, useContext, useMemo, useEffect } from 'react';
import { ThemeColors } from '../types';
import { THEME_COLORS, EMOTIONS } from '../constants';

const defaultTheme = THEME_COLORS[EMOTIONS[2].emoji]; // '보통'

const ThemeContext = createContext<ThemeColors>(defaultTheme);

export const useTheme = () => useContext(ThemeContext);

interface ThemeProviderProps {
    children: React.ReactNode;
    emotion: string;
}

export const ThemeProvider = ({ children, emotion }: ThemeProviderProps) => {
    const theme = useMemo(() => THEME_COLORS[emotion] || defaultTheme, [emotion]);

    useEffect(() => {
        const root = document.documentElement;
        root.style.setProperty('--scrollbar-thumb-bg', theme.scrollbarThumb);
        root.style.setProperty('--scrollbar-thumb-hover-bg', theme.scrollbarThumbHover);
        root.style.setProperty('--scrollbar-track-bg', theme.scrollbarTrack);
    }, [theme]);

    return (
        <ThemeContext.Provider value={theme}>
            {children}
        </ThemeContext.Provider>
    );
};