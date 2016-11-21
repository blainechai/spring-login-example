package com.blainechai.repository;

import com.blainechai.domain.UserBookmark;
import com.blainechai.domain.UserHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by blainechai on 2016. 10. 20..
 */
public interface UserBookmarkRepository extends JpaRepository<UserBookmark, Long> {

    List<UserBookmark> findByUserAccount_UserId(String userId);

    List<UserBookmark> findByUserAccount_UserIdAndWord(String userId, String word);

    @Transactional
    long deleteById(Long id);

    @Transactional
    long deleteByWord(Long word);

    @Transactional
    long deleteByUserAccount_UserIdAndWord(String userId, String word);
}