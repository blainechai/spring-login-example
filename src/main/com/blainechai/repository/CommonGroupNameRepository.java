package com.blainechai.repository;

import com.blainechai.domain.CommonGroupName;
import org.eclipse.persistence.annotations.CascadeOnDelete;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by blainechai on 2016. 11. 23..
 */
public interface CommonGroupNameRepository extends JpaRepository<CommonGroupName, Long> {

    List<CommonGroupName> findByGroupName(String groupName);

    List<CommonGroupName> findByGroupId(String groupId);

    @Transactional
    long deleteByGroupName(String groupName);

    @Transactional
    long deleteByGroupId(String groupId);
}
