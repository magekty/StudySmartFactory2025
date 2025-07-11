package com.example.cls_sb_250708_ex1.service;

import com.example.cls_sb_250708_ex1.model.TodoJpa;
import com.example.cls_sb_250708_ex1.repository.TodoJpaRepository;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.bean.override.mockito.MockitoBean;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

// tde(Test developement environment) - java server개발시 유용
@SpringBootTest
public class TodoJpaServiceTest {
    @Autowired
    private TodoJpaService todoJpaService;
    @MockitoBean
    private TodoJpaRepository todoJpaRepository;

    @Test
    void getAll_shouldReturnAllTodoJpa() {
        todoJpaService.getAll();
        verify(todoJpaRepository).findAll();
    }

    @Test
    void add_shouldSavedNewTodoJpa() {
        String title = "Test TodoJpa";
        todoJpaService.add(title);
        ArgumentCaptor<TodoJpa> captor = ArgumentCaptor.forClass(TodoJpa.class);
        verify(todoJpaRepository).save(captor.capture());
        assertThat(captor.getValue().getTitle()).isEqualTo(title);
        assertThat(captor.getValue().isDone()).isEqualTo(false);
    }

    @Test
    void findById_shouldReturnTodoJpa() {
        TodoJpa todojpa1 = new TodoJpa(1L, "title1", false);
        when(todoJpaRepository.findById(1L)).thenReturn(Optional.of(todojpa1));
        TodoJpa found = todoJpaService.findById(1L);
        assertThat(found).isEqualTo(todojpa1);
    }

    @Test
    void findById_shouldThrowIfNotFound() {
        when(todoJpaRepository.findById(2L)).thenReturn(Optional.empty());
        org.junit.jupiter.api.Assertions.assertThrows(
                RuntimeException.class,
                () -> todoJpaService.findById(2L)
        );
    }

    @Test
    void update_shouldChangeTodoJpa() {
        TodoJpa todojpa1 = new TodoJpa(1L, "title1", false);
        when(todoJpaRepository.findById(1L)).thenReturn(Optional.of(todojpa1));
        todoJpaService.update(1L, "title1_updated", true);
        assertThat(todojpa1.getTitle()).isEqualTo("title1_updated");
        assertThat(todojpa1.isDone()).isTrue();
        verify(todoJpaRepository).save(todojpa1);
    }

    @Test
    void delete_shouldDeleteTodoJpa() {
        todoJpaService.delete(1L);
        verify(todoJpaRepository).deleteById(1L);
    }
}
